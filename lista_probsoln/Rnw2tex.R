#!/usr/bin/env Rscript

# This script is to produce random list of exercices.
#
# -- Walmes Zeviani

#-----------------------------------------------------------------------
# NOTE! To be an executalble file:
# chmod +x Rnw2tex.R

rm(list = ls())
options(echo = FALSE)
args <- commandArgs(trailingOnly = TRUE)

# args <- c("estat_basica/PR_arvore.Rnw", "estat_basica/PR_circuito.Rnw", 1)
# args <- c("estat_basica/PR_arvoreProbDoencas.Rnw", 1)

usage <- '
Usage:

  ./Rnw2tex.R <basefile.Rnw> <number_of_exams>

Examples:

  ./Rnw2tex.R exam1.Rnw 6
  ./Rnw2tex.R exam2.Rnw 10
  ./Rnw2tex.R exam3.Rnw 1
\n'

if (length(args) == 0 | args[1] == "-h") {
    cat(usage)
    stop("Exiting")
}

n <- grepl(x = args, pattern = "^\\d$")
if (any(n)) {
    n <- as.integer(args[n][1])
} else {
    n <- 1L
}

somefiles <- sapply(args, file.exists)
files <- args[somefiles]

#--------------------------------------------
# Packages.

require(xtable)
require(knitr)

#--------------------------------------------

# Número de provas.
nexams <- n

#-----------------------------------------------------------------------
# Se o número de arquivos passados for maior que 1, então entende-se

path <- dirname(normalizePath(files[1]))
lines <- lapply(files, readLines)

if (length(files) > 1) {
    lines <- lapply(lines,
                    FUN = function(x) {
                        i <- grep("\\\\begin\\{defproblem\\}", x = x)
                        x <- append(x,
                                    value = "\\begin{ex}",
                                    after = i)
                        j <- grep("\\\\end\\{defproblem\\}", x = x)
                        x <- append(x,
                                    value = c("\\end{ex}\n\n"),
                                    after = j - 1)
                        return(x)
                })
    lines <- do.call(c, lines)
    name <- gsub(pattern = "^\\\\begin\\{defproblem\\}\\{(.*)_SEED_\\}",
                 replacement =  "\\1",
                 x = grep("^\\\\begin\\{defproblem\\}\\{.*\\}",
                          x = lines, value = TRUE))
    name <- paste(name, collapse = "--")
    lines <- grep("^\\\\(begin|end)\\{defproblem\\}",
                  x = lines, value = TRUE, invert = TRUE)
    lines <- c(sprintf("\\begin{defproblem}{%s}",
                       paste0(name, "_SEED_", collapse = "")),
               lines,
               "\\end{defproblem}")
    cat(lines, sep = "\n",
        file = sprintf("%s/%s.Rnw", path, name))
    rl0 <- lines
    basefile <- sprintf("%s/%s.Rnw", path, name)
    basefilename <- sub("\\.Rnw$", "", basefile)
} else {
    basefile <- files
    basefilename <- sub("\\.Rnw$", "", basefile)
    rl0 <- lines[[1]]
}

#-----------------------------------------------------------------------

# Header with chunck to define the prefix of figures.
header <- c("<<include=FALSE>>=",
            sprintf("opts_chunk$set(fig.path = \"%s/figure/%s_SEED_-\")",
                    path,
                    gsub(x = basefilename,
                         pattern = ".*/([^/]*)$",
                         replacement = "\\1")),
            "@", "")
rl0 <- c(header, rl0)

L <- vector(mode = "list", length = nexams)
for (i in seq_along(L)) {
    #----------------------------------------
    # Here a Snw file is generated based in the Rnw. Different copies
    # are obtained replacing the _SEED_ ocurrence by a integer
    # number. Diferent seed numbers build differents exams.
    x <- i
    rl1 <- gsub(pattern = "_SEED_",
                replacement = x,
                x = rl0)
    rl2 <- append(rl1,
                  values = c("",
                             paste(c("%", rep("=======", 10)),
                                   collapse = "")))
    L[[i]] <- rl2
}

# Put together all exams.
allexams <- do.call(c, L)

# Write out.
basefileout <- paste0(basefilename, ".Snw")
if (dir.exists("../tex/")) {
    writeLines(text = allexams,
               paste0("../tex/", basefileout))
    out <- paste0("../tex/", basefilename, ".tex")
    setwd("../tex/")
} else {
    writeLines(text = allexams,
               paste0("", basefileout))
    out <- paste0(basefilename, ".tex")
}

# It is needed because when chunks have `rm(list = ls())` the workspace
# (.GlobalEnv) is erased.
Rnw2tex <- as.environment(as.list(.GlobalEnv, all.names = TRUE))
attach(Rnw2tex)

# Compile Snw to tex.
knit(input = basefileout,
     output = out,
     encoding = "utf-8")

# Remove the file.
invisible(file.remove(get("basefileout", pos = 2)))

#-----------------------------------------------------------------------
