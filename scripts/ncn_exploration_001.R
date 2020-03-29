# Data cleaning and EDA for NCN grants data
#setwd("~/IAD/semestr-2/data-visualisation/ncn-grants/")

grants <- read.csv("./data/grants_larger.csv")
descriptors <- read.csv("./data/descriptors.csv")
grants_2019 <- read.csv("./data/ncn_2019.csv")
ncn_fiil <- read.csv("./data/ncn_fill.csv")

# Concat of 2019 data
grants_2019$type <- grants_2019$grant_type
grants_2019 <- grants_2019[, colnames(grants)]
grants <- rbind(grants, grants_2019)

# Join additional data from ncn fill
grants <- merge(grants, ncn_fiil, by = "id")

# 2 informations from type column: name & date
x <- strsplit(as.character(grants$type), " ") 

type_split <- lapply(grants$type, function(x) strsplit(as.character(x), "Konkurs: ")[[1]][2])
type_split <- lapply(type_split, function(x) strsplit(as.character(x), "  - ogłoszony ")[[1]])

comp_name <- lapply(type_split, function(x) x[1])

grants$comp <- unlist(comp_name)

#grants$comp_edition <- lapply(comp_name, function(x) x[[1]][length(x[[1]])])
#grants$comp_edition <- as.integer(grants$comp_edition)

grants$comp_date <- lapply(type_split, function(x) x[2])
grants$comp_date <- as.Date(unlist(grants$comp_date),  origin = "1970-01-01")

####
# split comp to a competition name and competition edition
comp_edition <- regmatches(gsub(" ", "", grants$comp), gregexpr('[0-9]+', gsub(" ", "", grants$comp)))
grants$comp_edition <- as.numeric(comp_edition)

comp_name <- lapply(grants$comp, function(x) strsplit(x, " ")[[1]])
comp_name <- lapply(comp_name, function(x) paste(x[1:(length(x) - 1)], collapse = " "))
comp_name <- unlist(comp_name)
grants$comp_name <- comp_name

# subpanel -> code + name

subpanels <- lapply(grants$subpanel, function(x) strsplit(as.character(x), " ")[[1]])
subpanel_code <- lapply(subpanels, function(x) x[1])
grants$subpanel_code <- as.character(subpanel_code)

subpanel_description <- lapply(subpanels, function(x) x[5:length(x)])
subpanel_description <- lapply(subpanel_description, function(x) paste(x[1:length(x)], collapse = " "))
grants$subpanel_description <- as.character(subpanel_description)

#convert budget
budgets_pln <- regmatches(gsub(" ", "", grants$budget), gregexpr('[0-9]+', gsub(" ", "", grants$budget)))
budgets_pln <- unlist(budgets_pln)
grants$budget_pln <- as.numeric(budgets_pln)

# duration -> duration in months
duration_months <- regmatches(gsub(" ", "", grants$duration), gregexpr('[0-9]+', gsub(" ", "", grants$duration)))
duration_months <- unlist(duration_months)
grants$duration_months <- as.numeric(duration_months)

# parse coinvestigators
coinvestigators_count <- regmatches(gsub(" ", "", grants$coinvestigators),
                                    gregexpr('[0-9]+', gsub(" ", "", grants$coinvestigators)))

coinvestigators_count <- as.numeric(coinvestigators_count) 
grants$coinvestigators_cnt <- coinvestigators_count

grants$subpanel_code_type <- as.character(lapply(grants$subpanel_code,
                                                 function(x) substr(x, 1, 2)))
grants$subpanel_code_number <- as.numeric(lapply(grants$subpanel_code,
                                                   function(x) substr(x, 3, 3)))

### Preprocessing for grants data -- done!

# TODO: Investigate descriptors

grants <- grants[, c("id",
                     "title",
                     "institution",
                     "project_status",
                     "comp_date",
                     "comp_name",
                     "comp_edition",
                     "subpanel_code_type",
                     "subpanel_code_number",
                     "subpanel_description",
                     "budget_pln",
                     "duration_months",
                     "coinvestigators_cnt")]

write.csv(grants,
          file = "./data/grants_preprocessed.csv",
          row.names = FALSE)
View(grants)
