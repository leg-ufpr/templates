#-----------------------------------------------------------------------
# Autores e títulos dos trabalhos.

txt <-
"Tomás de Siervi Barcellos;Introdução a visualização de dados no R com ggplot2
José de Jesus Filho;Gerando relatórios preformatados com Shiny, Bookdown e Glue.
Eduardo Elias Ribeiro Junior;Criando websites com blogdown
William Nilson de Amorim;Introdução ao Shiny
Bernardo Dias Bordalo Loureiro;Introdução ao Machine Learning Services - utilizando o R
Clarissa Simoyama David;Mineração de Dados aplicada à economia utilizando R
Samuel Victor Medeiros de Macêdo;Análise de Big Data utilizando o pacote sparklyr
Caio Lente;ddR: Estruturas de Dados Distribuídas em R"

trabs <- read.csv2(textConnection(txt),
                   header = FALSE,
                   stringsAsFactors = FALSE)
trabs$V3 <- 1
str(trabs)

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
doc <- readLines(con = "cartas.tex")
cat(doc, sep = "\n")

# Linha onde está o autor e o título do trabalho no arquivo molde.
tp <- grep("\\.\\.cartatipo\\.\\.", doc)[1]
au <- grep("\\.\\.autor\\.\\.", doc)[1]
ti <- grep("\\.\\.titulo\\.\\.", doc)[1]

doc2 <- doc

# Executa o laço.
for (i in 1:nrow(trabs)) {
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
    fl <- sprintf("carta-%03d.tex", i)
    cat(doc2, sep = "\n", file = fl)
    system(sprintf("pdflatex %s", fl))
    file.remove(fl)
}

# Faz a junção dos PDFs.
system("ls carta-*.pdf")
system("pdfunite carta-*.pdf cartas-rday.pdf")

# Remove os arquivos não mais necessários.
system("rm -v carta-*.tex")
system("rm -v carta-*.pdf")
system("rm -v *.log *.aux")

#-----------------------------------------------------------------------
