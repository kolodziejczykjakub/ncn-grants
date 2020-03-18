grants_name <- c("OPUS",
                 "SONATA",
                 "HARMONIA",
                 "PRELUDIUM",
                 "MAESTRO",
                 "FUGA",
                 "SONATA BIS",
                 "SYMFONIA",
                 "ETIUDA",
                 "UNISONO",
                 "BEETHOVEN",
                 "POLONEZ",
                 "SONATINA",
                 "UWERTURA",   
                 "DAINA",
                 "SHENG")

description <- c("konkurs na projekty badawcze otwarty dla wszystkich naukowców",
                 "konkurs na projekty badawcze realizowane przez osoby posiadające stopień naukowy doktora",
                 "konkurs na projekty badawcze realizowane w ramach współpracy międzynarodowej",
                 "konkurs na projekty badawcze realizowane przez osoby nieposiadające stopnia naukowego doktora",
                 "konkurs dla doświadczonych naukowców na projekty badawcze mające na celu realizację pionierskich badań naukowych, w tym interdyscyplinarnych, ważnych dla rozwoju nauki, wykraczających poza dotychczasowy stan wiedzy, których efektem mogą być odkrycia naukowe",
                 "konkurs na krajowe staże po uzyskaniu stopnia naukowego doktora",
                 "konkurs na projekty badawcze mające na celu powołanie nowego zespołu naukowego, realizowane przez osoby posiadające stopień naukowy lub tytuł naukowy, które uzyskały stopień naukowy doktora w okresie od 5 do 12 lat przed rokiem wystąpienia z wnioskiem",
                 "konkurs na międzydziedzinowe projekty badawcze realizowane przez wybitnych naukowców, przekraczające granice dyscyplin naukowych",
                 "konkurs na stypendia doktorskie",
                 "konkurs na w oparciu o procedurę agencji wiodącej (Lead Agency Procedure, „LAP”) na dwustronne lub trójstronne projekty badawcze dla zespołów z Austrii, Czech, Słowenii i Polski w ramach programu wielostronnego CEUS.", # needs double check
                 "BEETHOVEN CLASSIC– konkurs na polsko-niemieckie projekty badawcze z zakresu nauk humanistycznych, społecznych i o sztuce oraz wybranych dyscyplin nauk ścisłych i technicznych, realizowane przez zespoły polsko-niemieckie;
BEETHOVEN LIFE– konkurs na polsko-niemieckie projekty badawcze z zakresu nauk o życiu, realizowane przez zespoły polsko-niemieckie",
                 "konkurs dla naukowców przyjeżdżających z zagranicy",
                 "na projekty badawcze realizowane przez osoby posiadające stopień naukowy doktora, uzyskany w okresie do 3 lat przed rokiem wystąpienia z wnioskiem",
                 "konkurs na staże w zagranicznych zespołach naukowych realizujących granty ERC",
                 "konkurs na polsko-litewskie projekty badawcze",
                 "konkurs na polsko-chińskie projekty badawcze")


grants_description <- data.frame("competitionName" = grants_name,
                                 "competitionDescription" = description)
