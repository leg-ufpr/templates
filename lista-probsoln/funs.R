#' @name randomize
#' @param x Um vetor no qual o primeiro elemento representa a
#'     alternativa correta e os demais são alternativas incorretas.
#' @return Retorna uma lista com dois elementos. No primeiro,
#'     \code{items}, contém as alternativas embaralhadas. O segundo,
#'     \code{correct}, contém a posição da alternativas correta.
randomize <- function(x) {
    a <- sample(seq_along(x))
    list(items = x[a],
         correct = which(a == 1))
}

#' @name solution
#' @param x Uma lista produzida pela função \code{randomize}, com dois
#'     elementos \code{items} e \code{correct}.
#' @return Retorna uma string com a letra da alternativa correta e o
#'     correspondente valor.
solution <- function(x, digits = 4) {
    stopifnot(is.list(x) & all(names(x) == c("items", "correct")))
    sprintf("%s) %s",
            letters[x$correct],
            if (is.numeric(x$items)) {
                paste0("$",
                       round(x$items[x$correct], digits = digits),
                       "$")
            } else {
                x$items[x$correct]
            })
}

#' @name formatitems
#' @title Formata alternativas
#' @param x vetor numérico ou string com alternativas da questão.
#' @param digits Número de digitos usados para formatar alternativas que
#'     sejam numéricas.
#' @param prepend A string que deve ser colocada antes das
#'     alternativas. O valor default é \code{"\\item"}.
#' @param pospend A string que deve ser colocada depois das
#'     alternativas. O valor default é \code{"; \\hfill"}.
#' @return retorna um vetor de strings de tamanho igual ao vetor
#'     passado no argumento \code{x}.
formatitems <- function(x,
                        digits = 4,
                        prepend = "\\item",
                        pospend = "; \\hfill",
                        OutDec = options()$OutDec) {
    if (is.numeric(x)) {
        y <- sprintf(paste0("%s $%0.", digits, "f$%s"),
                     prepend, x, pospend)
        if (OutDec == ",") {
            y <- sub(pattern = "\\.", replacement = ",", x = y)
        }
    } else {
        y <- sprintf("%s %s%s", prepend, x, pospend)
    }
    return(y)
}

#' @param target Valor alvo que corresponde a resposta certa.
#' @param n número de valores candidatos que são as respostas erradas.
#' @param range vetor com os extremos, \code{min} e \code{max}, do
#'     limite para geração de número uniformes com a \code{runif()}.
#' @param mindiff menor diferença possível entre duas alternativas.
#' @return Um vetor com \code{n+1} elementos, sendo o primeiro o valor
#'     passo em \code{target} e os demais, as alternativas geradas.
#' @examples
#'
#' candidates(target = 0.25, n = 5, range = 0:1, mindiff = diff(range)/20)
#'
#' apply(replicate(50, candidates(target = 0.5, n = 5, range = 0:1, mindiff = diff(range)/20)), 2,
#'       function(x) {min(diff(sort(x)))})
candidates <- function(target,
                       n = 5,
                       range,
                       mindiff = diff(range)/20) {
    tot <- diff(range)
    if (tot/mindiff < 2 * n) stop("`mindiff` grande para `range` e `n` passados.")
    x <- c(target, numeric(0))
    k <- 0
    i <- 0
    repeat {
        u <- runif(n = 1, min = range[1], max = range[2])
        if (all(abs(x - u) >= mindiff)) {
            x <- c(x, u)
            k <- k + 1
        }
        if (k >= n) break
        i <- i + 1
        if (i > 50) break
    }
    return(x)
}

#' @param prefix Uma string para ser o prefixo do nome aleatório.
#' @return Uma string com sufixo aleatório. Essa string pode ser usada
#'     como nome de objeto para guardar a resposta de cada exercício.
#' @examples
#'
#' x <- tmpname()
#' assign(x = x, value = 100)
#' ls()
#' get(x)
#'
tmpname <- function(prefix = "answer") {
    sub("/", "", tempfile(pattern = "answer", tmpdir = ""))
}

# função para colocar as alternativas dentro do ambiente tabular, melhor formatação dos resultados.
intable <- function(x, type="1x4"){
  #' @param x vetor de alternativas
  #' @param type tipo de arranjo, 1x4, 2x2, 4x1.
  switch(type,
         "2x2" = paste("\n\\begin{tabular}{ll}",
                       x[1],
                       "&",
                       x[3],
                       "\\tabularnewline",
                       x[2],
                       "&",
                       x[4],"\\end{tabular}\n"),
         "1x4" = paste("\n\\begin{tabular}{llll}",
                       x[1],
                       "&", 
                       x[2],
                       "&",
                       x[3],
                       "&",
                       x[4],
                       "\\end{tabular}\n"),
         "4x1" = paste("\n\\begin{tabular}{l}",
                       x[1],
                       "\\tabularnewline",
                       x[2],
                       "\\tabularnewline",
                       x[3],
                       "\\tabularnewline",
                       x[4],
                       "\\end{tabular}\n")
         )
}
