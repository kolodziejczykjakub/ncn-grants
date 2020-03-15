# Data cleaning and EDA for NCN grants data
#setwd("~/IAD/semestr-2/data-visualisation/ncn-grants/")

grants <- read.csv("./data/grants_larger.csv")
descriptors <- read.csv("./data/descriptors.csv")

# 2 informations from type column: name & date
x <- strsplit(as.character(grants$type), " ") 

type_split <- lapply(grants$type, function(x) strsplit(as.character(x), "Konkurs: ")[[1]][2])
type_split <- lapply(type_split, function(x) strsplit(as.character(x), "  - ogłoszony ")[[1]])

comp_name <- lapply(type_split, function(x) x[1])

grants$comp <- unlist(comp_name)

#TODO: split comp to a competition name and competition edition
#grants$comp_edition <- lapply(comp_name, function(x) x[[1]][length(x[[1]])])
#grants$comp_edition <- as.integer(grants$comp_edition)

grants$comp_date <- lapply(type_split, function(x) x[2])
grants$comp_date <- as.Date(unlist(grants$comp_date),  origin = "1970-01-01")

####
# TODO: subpanel -> code + name
# TODO: convert budget
# TODO: duration -> duration in months
# TODO: parse coinvestigators