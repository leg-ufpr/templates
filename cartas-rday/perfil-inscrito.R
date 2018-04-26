library(tidyverse)

ins <- read_csv2("inscricao.csv")
str(ins)

# dput(names(ins))
names(ins) <- c("cod",
                "nome",
                "email",
                "local",
                "inst",
                "categ",
                "termo",
                "lat",
                "lon",
                "lated",
                "loned",
                "infpor",
                "atupor",
                "infem",
                "atupor")

x <- iconv(x = ins$local, to = "ASCII//TRANSLIT")
x <- toupper(x)
x <- gsub(x = x, "[[:space:][:punct:]]", "")

ins$localx <- x

ggplot(data = ins) +
    geom_point(mapping = aes(x = lon, y = lat))

ggplot(data = ins,
       mapping = aes(x = reorder(localx, localx, length))) +
    geom_bar(na.rm = TRUE) +
    coord_flip()

# rot <- data.frame(old = unique(x))
# rot$new <- rot$old
# rot <- edit(rot)
# dput(rot)
structure(list(old = structure(1:74, .Label = c("028ANANINDEUA",
"ALFENASMG", "ANANINDEUAPA", "ARACAJUSE", "ARAQUARISC", "ARARASSP",
"BELEMPA", "BELOHORIZONTEMG", "BOTUCATUSP", "BRASILIA", "BRASILIADF",
"CAMPINAGRANDEPB", "CAXIASMA", "CHAPECOSC", "CRICIUMASC", "CRUZDASALMASBA",
"CUIABAMT", "CURITBAPR", "CURITIBA", "CURITIBANOS", "CURITIBANOSSC",
"CURITIBAPARANA", "CURITIBAPR", "DIAMANTINA", "DIAMANTINAMG",
"DOURADOSMS", "FLORIANOPOLIS", "FLORIANOPOLISSC", "GOIANIA",
"GOIANIAGO", "GOIOEREPR", "ITAPETININGASP", "ITAPEVASP", "LAGESSC",
"LAVRAS", "LAVRASMG", "LORENASP", "MARINGA", "MARINGAPR", "MINASGERAIS",
"MONTECARMELOMG", "MONTESCLAROSMINASGERAIS", "NITEROIRJ", "PATOBRANCO",
"PELOTASRS", "PINHAISPR", "PIRACICABA", "PIRACICABASAOPAULO",
"PIRACICABASP", "PONTAGROSSA", "RECIFEPE", "RIODEJANEIRO", "RIODEJANEIRORJ",
"RIORJ", "RIOVERDE", "SALVADORBA", "SANTAGERTRUDESSP", "SANTAMARIARS",
"SANTOANDRESP", "SAOCARLOSSP", "SAOJOSEDOSPINHAISPR", "SAOPAULO",
"SAOPAULOPR", "SAOPAULOSP", "SOROCABASP", "SYDNEYNSW", "TRESCORACOESMG",
"TRESPASSOSRS", "TRESPONTASMINASGERAIS", "URUTAIGO", "VARGINHA",
"VARGINHAMG", "VARGINHAMINASGERAIS", "VICOSAMG"), class = "factor"),
    new = structure(c(132L, 100L, 132L, 89L, 91L, 102L, 93L,
    107L, 108L, 86L, 86L, 115L, 87L, 95L, 94L, 111L, 114L, 81L,
    76L, 101L, 101L, 75L, 75L, 121L, 121L, 130L, 90L, 90L, 82L,
    82L, 113L, 116L, 104L, 103L, 80L, 80L, 127L, 112L, 112L,
    119L, 129L, 92L, 128L, 98L, 120L, 126L, 77L, 77L, 77L, 117L,
    105L, 79L, 79L, 79L, 125L, 99L, 122L, 106L, 131L, 83L, 109L,
    78L, 78L, 78L, 97L, 84L, 118L, 85L, 124L, 123L, 110L, 110L,
    110L, 96L), .Label = c("028ANANINDEUA", "ALFENASMG", "ANANINDEUAPA",
    "ARACAJUSE", "ARAQUARISC", "ARARASSP", "BELEMPA", "BELOHORIZONTEMG",
    "BOTUCATUSP", "BRASILIA", "BRASILIADF", "CAMPINAGRANDEPB",
    "CAXIASMA", "CHAPECOSC", "CRICIUMASC", "CRUZDASALMASBA",
    "CUIABAMT", "CURITBAPR", "CURITIBA", "CURITIBANOS", "CURITIBANOSSC",
    "CURITIBAPARANA", "CURITIBAPR", "DIAMANTINA", "DIAMANTINAMG",
    "DOURADOSMS", "FLORIANOPOLIS", "FLORIANOPOLISSC", "GOIANIA",
    "GOIANIAGO", "GOIOEREPR", "ITAPETININGASP", "ITAPEVASP",
    "LAGESSC", "LAVRAS", "LAVRASMG", "LORENASP", "MARINGA", "MARINGAPR",
    "MINASGERAIS", "MONTECARMELOMG", "MONTESCLAROSMINASGERAIS",
    "NITEROIRJ", "PATOBRANCO", "PELOTASRS", "PINHAISPR", "PIRACICABA",
    "PIRACICABASAOPAULO", "PIRACICABASP", "PONTAGROSSA", "RECIFEPE",
    "RIODEJANEIRO", "RIODEJANEIRORJ", "RIORJ", "RIOVERDE", "SALVADORBA",
    "SANTAGERTRUDESSP", "SANTAMARIARS", "SANTOANDRESP", "SAOCARLOSSP",
    "SAOJOSEDOSPINHAISPR", "SAOPAULO", "SAOPAULOPR", "SAOPAULOSP",
    "SOROCABASP", "SYDNEYNSW", "TRESCORACOESMG", "TRESPASSOSRS",
    "TRESPONTASMINASGERAIS", "URUTAIGO", "VARGINHA", "VARGINHAMG",
    "VARGINHAMINASGERAIS", "VICOSAMG", "CURITIBA-PR", "CURITIBA-MT",
    "PIRACICABA-SP", "SAOPAULO-SP", "RIODEJANEIRO-RJ", "LAVRAS-MG",
    "CURITBA-PR", "GOIANIA-GO", "SAOCARLOS-SP", "SYDNEY-NSW",
    "TRESPASSOS-RS", "BRASILIA-DF", "CAXIAS-MA", "028ANANIND-EUA",
    "ARACAJU-SE", "FLORIANOPOLIS-SC", "ARAQUARI-SC", "MONTESCLAROS-MG",
    "BELEM-PA", "CRICIUMA-SC", "CHAPECO-SC", "VICOSA-MG", "SOROCABA-SP",
    "PATOBRANCO-PR", "SALVADOR-BA", "ALFENAS-MG", "CURITIBANOS-SC",
    "ARARAS-SP", "LAGES-SC", "ITAPEVA-SP", "RECIFE-PE", "SANTAMARIA-RS",
    "BELOHORIZONTE-MG", "BOTUCATU-SP", "SAOJOSEDOSPINHAIS-PR",
    "VARGINHA-MG", "CRUZDASALMAS-BA", "MARINGA-PR", "GOIOERE-PR",
    "CUIABA-MT", "CAMPINAGRANDE-PB", "ITAPETININGA-SP", "PONTAGROSSA-PR",
    "TRESCORACOES-MG", "MG", "PELOTAS-RS", "DIAMANTINA-MG", "SANTAGERTRUDES-SP",
    "URUTAI-GO", "TRESPONTAS-MG", "RIOVERDE-GO", "PINHAIS-PR",
    "LORENA-SP", "NITEROI-RJ", "MONTECARMELO-MG", "DOURADOS-MS",
    "SANTOANDRE-SP", "ANANINDEUA-PA"), class = "factor")), .Names = c("old",
"new"), row.names = c("15", "33", "23", "16", "20", "35", "24",
"40", "42", "50", "13", "52", "14", "27", "26", "45", "51", "7",
"2", "57", "34", "41", "1", "61", "72", "73", "19", "18", "21",
"8", "48", "53", "37", "36", "25", "6", "68", "49", "47", "59",
"71", "22", "70", "30", "60", "67", "56", "31", "3", "54", "38",
"17", "12", "5", "66", "32", "62", "39", "74", "9", "43", "63",
"69", "4", "29", "10", "58", "11", "65", "64", "44", "55", "46",
"28"), class = "data.frame")
rot <- as.data.frame(rot, stringsAsFactors = FALSE)
rot <- rot[order(as.character(rot$old)), ]

ins$localx <- rot$new[match(x, rot$old)]

ggplot(data = ins,
       mapping = aes(x = reorder(localx, localx, length))) +
    geom_bar(na.rm = TRUE) +
    coord_flip()

ins$uf <- gsub(x = ins$localx, "^.*-", "")

ggplot(data = ins,
       mapping = aes(x = reorder(uf,
                                 uf,
                                 function(x) length(x)))) +
    geom_bar(na.rm = TRUE) +
    coord_flip()

str(ins)

ggplot(data = ins,
       mapping = aes(x = reorder(categ,
                                 categ,
                                 function(x) 1/length(x)))) +
    geom_bar(na.rm = TRUE)

ggplot(data = ins,
       mapping = aes(x = reorder(inst,
                                 inst,
                                 function(x) length(x)))) +
    geom_bar(na.rm = TRUE) +
    coord_flip()

#-----------------------------------------------------------------------
