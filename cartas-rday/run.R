#-----------------------------------------------------------------------
# Autores e títulos dos trabalhos.

# txt <-
# "Tomás de Siervi Barcellos;Introdução a visualização de dados no R com ggplot2
# José de Jesus Filho;Gerando relatórios preformatados com Shiny, Bookdown e Glue.
# Eduardo Elias Ribeiro Junior;Criando websites com blogdown
# William Nilson de Amorim;Introdução ao Shiny
# Bernardo Dias Bordalo Loureiro;Introdução ao Machine Learning Services - utilizando o R
# Clarissa Simoyama David;Mineração de Dados aplicada à economia utilizando R
# Samuel Victor Medeiros de Macêdo;Análise de Big Data utilizando o pacote sparklyr
# Caio Lente;ddR: Estruturas de Dados Distribuídas em R"
#
# trabs <- read.csv2(textConnection(txt),
#                    header = FALSE,
#                    stringsAsFactors = FALSE)
# trabs$V3 <- 1
# str(trabs)

trabs <- read.csv2("tutoriais-apresentacoes.csv",
                   header = FALSE,
                   stringsAsFactors = FALSE)
str(trabs)

trabs <- trabs[complete.cases(trabs), ]
trabs <- trabs[order(trabs[, 1]), ]

# trabs[, 1] <- toupper(trabs[, 1])
# trabs[, 2] <- toupper(trabs[, 2])

# n <- nrow(trabs)
# trabs <- rbind(trabs, trabs)
# trabs$V2[1:n] <- "NULL"
# trabs$V3[1:n] <- 0

cat(trabs[, 1], sep = "\n")
cat(trabs[, 2], sep = "\n")
cat(trabs[, 3], sep = "\n")

#-----------------------------------------------------------------------
# Lê o molde e faz a mala direta.

# Lê o molde.
doc <- readLines(con = "run-cartas.tex")
cat(doc, sep = "\n")

# Linha onde está o autor e o título do trabalho no arquivo molde.
tp <- grep("\\.\\.cartatipo\\.\\.", doc)[1]
au <- grep("\\.\\.autor\\.\\.", doc)[1]
ti <- grep("\\.\\.titulo\\.\\.", doc)[1]

hj <- grep("\\.\\.hoje\\.\\.", doc)[1]
doc[hj] <- sub(pattern = "\\.\\.hoje\\.\\.",
               replacement = format(Sys.Date(), format = "%d de %B de %Y"),
               x = doc[hj])

doc2 <- doc

#-----------------------------------------------------------------------

# Executa o laço.
for (i in 1:nrow(trabs)) {
# for (i in 1:4) {
    autor <- trabs[i, 1]
    titul <- trabs[i, 2]
    tipo <- trabs[i, 3]
    doc2[au] <- sub(pattern = "\\.\\.autor\\.\\.",
                   replacement = autor,
                   x = doc[au])
    doc2[ti] <- sub(pattern = "\\.\\.titulo\\.\\.",
                   replacement = titul,
                   x = doc[ti])
    doc2[tp] <- sub(pattern = "\\.\\.cartatipo\\.\\.",
                   replacement = tipo,
                   x = doc[tp])
    fl <- sprintf("carta-%02d-%s.tex", i,
                  gsub(pattern = "[[:space:]]",
                       replacement = "",
                       x = iconv(x = autor, to = "ASCII//TRANSLIT")))
    cat(doc2, sep = "\n", file = fl)
    # Compilar 3x para aparecer a imagem de background.
    system(sprintf("pdflatex %s", fl))
    system(sprintf("pdflatex %s", fl))
    system(sprintf("pdflatex %s", fl))
    system("rm -v carta-*.tex *.log *.aux")
}

# Faz a junção dos PDFs.
system("ls -l -n carta-*.pdf")
system("rm -r cartas && mkdir cartas && mv -v carta-*.pdf cartas/")
unlink("cartas", recursive = TRUE)
dir.create(path = "cartas")
system("mv -v carta-*.pdf cartas/")
zip(zipfile = "cartas.zip",
    files = dir(path = "cartas", full.names = TRUE))
file.copy(from = "cartas.zip", to = "~/Dropbox/RevoLEG")

system("pdfunite carta-*.pdf cartas-rday.pdf")

# Remove os arquivos não mais necessários.
system("rm -v carta-*.tex")
system("rm -v carta-*.pdf")
system("rm -v carta-*.tex *.log *.aux")

#-----------------------------------------------------------------------

insc <- read.csv2("inscricao.csv",
                  header = TRUE,
                  stringsAsFactors = FALSE)
str(insc)

nom <- toupper(sort(insc[, 2]))
length(nom)
head(nom)

# for (i in seq_along(nom)[1:3]) {
for (i in seq_along(nom)) {
# for (i in 1:4) {
    doc2[au] <- sub(pattern = "\\.\\.autor\\.\\.",
                   replacement = nom[i],
                   x = doc[au])
    doc2[tp] <- sub(pattern = "\\.\\.cartatipo\\.\\.",
                   replacement = 0,
                   x = doc[tp])
    fl <- sprintf("insc-%03d-%s.tex", i,
                  gsub(pattern = "[[:space:]]",
                       replacement = "_",
                       x = iconv(x = nom[i],
                                 to = "ASCII//TRANSLIT")))
    cat(doc2, sep = "\n", file = fl)
    # Compilar 3x para aparecer a imagem de background.
    system(sprintf("pdflatex %s", fl))
    system(sprintf("pdflatex %s", fl))
    system(sprintf("pdflatex %s", fl))
    system("rm -v insc-*.tex *.log *.aux")
}

system("ls -l -n insc-*.pdf")
unlink("inscricoes", recursive = TRUE)
dir.create(path = "inscricoes")
system("mv -v insc-*.pdf inscricoes/")
zip(zipfile = "inscricoes.zip",
    files = dir(path = "inscricoes", full.names = TRUE))
file.copy(from = "inscricoes.zip", to = "~/Dropbox/RevoLEG")

system("pdfunite insc-*.pdf inscricoes-rday.pdf")
system("rm -v insc-*.tex insc-*.pdf *.log *.aux")

#-----------------------------------------------------------------------
