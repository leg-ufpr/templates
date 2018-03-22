#-----------------------------------------------------------------------
# Autores e títulos dos trabalhos.

txt <- "Sra Isabella Oliveira Martins;Análise do impacto do consumo das famílias na taxa de crescimento da economia utilizando o modelo VAR
Sr Manoel Vitor de Souza Veloso;Análise do impacto do consumo das famílias na taxa de crescimento da economia utilizando o modelo VAR
Sra Mayara Cristine dos Reis;Análise da taxa bruta de mortalidade para o estado  de Minas Gerais utilizando Regressão linear múltipla
Sra Jayne de Proença Salles;Análise da taxa bruta de mortalidade para o estado  de Minas Gerais utilizando Regressão linear múltipla
Sr Taylor Oliveira Fidelis;Análise do desempenho bancário brasileiro utilizando análise multivariada e metodologia CAMEL
Sra Camila Moreira Ribeiro;Análise temporal do número de endividamento e inadimplência das famílias no Brasil, no período de janeiro de 2010 a dezembro de 2017, utilizando a metodologia GLARMA Poisson
Sra Letícia Lima Milani Rodrigues;Análise temporal do número de endividamento e inadimplência das famílias no Brasil, no período de janeiro de 2010 a dezembro de 2017, utilizando a metodologia GLARMA Poisson
Sr Matheus Saraiva Alcino;Retorno anormal acumulado das ações do setor bancário no período de 1986 a 2017
Sr Danilo Machado Pires;Testes de Hipóteses fuzzy aplicados em Ciências Atuariais
Sr Denismar Alves Nogueira;Comparação de testes sobre estruturas de covariância de populações normais
Sr Eric Batista Ferreira;Comparação de testes sobre estruturas de covariância de populações normais
Sra Bárbara Alves Lopes;Análise do Consumo de gasolina no Brasil do período de 2005 a 2017 a partir da metodologia de Box-Jenkins
Sra Bruna Leandra Zeferino Silva;Estudo econométrico para o índice de confiança do consumidor em função de variáveis macroeconômicas no período de 2005 a  2015
Sr Leonardo Biazoli;Análise espacial e multivariada da Esperança de vida ao nascer
Sr Luiz Otávio de Oliveira Pala;Análise das cotações da commoditie do café brasileiro utilizando o modelo Bayesiano de volatilidade estocástica SV-AR(p)
Sra Gislene Araujo Pereira;Análise das cotações da commoditie do café brasileiro utilizando o modelo Bayesiano de volatilidade estocástica SV-AR(p)
Sra Poliana Maria Benelli;Estudo dos modelos de precificação de ativos em uma instituição bancária
Sra Josiane Correia de Souza Carvalho;Utilizando séries temporais na previsão do número de passageiros nos voos Brasileiros
Sr Gabriel Alves São Severino;Influência da previdência fechada e do envelhecimento populacional na previdência aberta
Sr Leonardo Henrique de Andrade Bento do Nascimento;Análise da Exportação de Café Brasileiro no período de 1994 a 2010
Sra Fernanda Mayumi Nishihata;Análise da Exportação de Café Brasileiro no período de 1994 a 2010
Sra Raquel Maduro Ayres Bandeira;As cotações diárias da JBS S/A em 2017: modelagem utilizando uma análise de intervenção
Sr Marcelo Augusto Martins Teodoro;Determinantes da Esperança de Vida ao Nascer para o Sul/Sudoeste de Minas Gerais em 2010
Sra Sarah de Sousa Moreira;Determinantes da Esperança de Vida ao Nascer para o Sul/Sudoeste de Minas Gerais em 2010
Sra Andréia do Carmo de Oliveira;Modelagem da temperatura mínima mensal de Piracicaba-SP via Distribuição Generalizada de Valores Extremos
Sr Luiz Henrique Marra da Silva Ribeiro;Modelagem do número de certificações ISO 9001 emitidos para o Brasil e Chile
Sra Michele Martins Lopes;Comparação de modelos epidemiológicos para  propagação de informações
Sra Valdeline de Paula Mequelino Ferreira;Níveis de retorno para valores máximos de temperatura Piracicaba-SP
Sra Rafaela da Silva Gomes;Análise estatística do consumo de Metilfenidato nos estados de Minas Gerais, Rio de Janeiro e São Paulo entre os anos de 2008 e 2014"

trabs <- read.csv2(textConnection(txt),
                   header = FALSE,
                   stringsAsFactors = FALSE)
str(trabs)

cat(trabs[, 1], sep = "\n")
cat(trabs[, 2], sep = "\n")

#-----------------------------------------------------------------------
# Lê o molde e faz a mala direta.

library(knitr)
library(rmarkdown)

# Lê o molde.
doc <- readLines(con = "carta.Rmd")
cat(doc, sep = "\n")

# Troca a data.
i <- grep("^date:", doc)[1]
if (length(i)) {
    doc[i] <- "date: \"Curitiba, 22 de Março de 2018\""
}

# Linha onde está o autor e o título do trabalho no arquivo molde.
to <- grep("^to:", doc)[1]
ti <- grep("^\"\\*\\*.*\\*\\*\"$", doc)[1]

# Executa o laço.
for (i in 1:nrow(trabs)) {
    au <- trabs[i, 1]
    tt <- trabs[i, 2]
    doc[to] <- sub(pattern = "\".*\"",
                   replacement = sprintf("\"%s\"", au),
                   x = doc[to])
    doc[ti] <- sprintf("\"**%s**\"", tt)
    fl <- sprintf("carta-%02d-%s.Rmd", i, gsub(x = au, "\\s+", ""))
    cat(doc, sep = "\n", file = fl)
    render(input = fl)
    file.remove(fl)
}

# Faz a junção dos PDFs.
system("ls carta-*.pdf")
system("pdfunite carta-*.pdf cartas-de-aceite.pdf")

# Remove os arquivos não mais necessários.
system("rm -v carta-*.Rmd")
system("rm -v carta-*.pdf")

#-----------------------------------------------------------------------
