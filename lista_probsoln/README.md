Produção de Listas de Exercício com `probsoln`
==============================================

## Objetivo

Esse template tem por finalidade facilitar a produção de listas de
exercícios com o pacote `probsoln` do LaTeX associado os recursos do
`knitr`.

## Descrição dos Componentes

`lista.Rmd`
:  É o arquivos Rmarkdown que contém a definição da lista de exercícios
no YAML. O YAML será descrito na seção [Parâmetros do YAML](#parametros-do-yaml). O arquivo
`lista-unica.Rmd` e `lista-aleatoria` definem dois tipos de exercícios.

`template.tex`
:  É o arquivo LaTeX, com as definições de preâmbulo, que irá recever os
valores passados no YAML. Não há necessidade de editar esse arquivo, a
menos de necessidade de inclusão de pacotes ou customização.

`dist-amostral.Rnw`
:  É um exemplo de exercício onde a geração de versões aleatórias está
habilitada. Note dentro do arquivo a marcação `_SEED_`. Essa marcação
será substituida por um valor de semente ao utililizar o script
`Rnw2tex.R`.

`Rnw2tex.R`
:  Esse script R é para rodar no shell. Ele tem dois argumentos: o nome
do arquivo `Rnw` e o número de versões a serem produzidas (opcional). No
shell pode-se usar assim: `$ ./Rnw2tex distr-amostral.Rnw 5`, que vai
gerar um `tex` com 5 cópias do exercício, cada uma delas vinculada a uma
semente.

`exame.tex`
:  Este é um arquivo com vários exercícios definidos. Eles não são
aleatórios. Portanto, quando os exercícios não são aleatórios, eles
podem ser definidos em TeX. Este é o caso de questões abertas.

`funs.R`
:  É um script que contém funções usadas na geração dos exercícios.

## Parâmetros do YAML

```
---
title: '**Título da Prova ou Lista**'
lecturer: Nome do Professor
email: '`emaildoprofessor@ufpr.br`'
department: Departamento de Estatística
chair: CE123 - Nome da Disciplina
url: '`https://url.da.disciplina`'
class: Nome do Curso
date: 12/12/12
exercises:
  - exame-2013
  - exame-2014
  - exame-2015
varied: 0
answers: hide
output:
  pdf_document:
    template: template.tex
    keep_tex: true
---
```

Os campos que precisam de comentário são apenas 3.

`exercises`
:  Esse campo lista os arquivos que contém os exercícios a serem
colocados na prova. Cada arquivo deve estar precedido de um traço
devidamente indentado, não deve ter a extensão do arquivo. **Não use
nome de arquivo com underscore** pois isso dá problema quando é feito o
parse para o LaTeX (`meu_arquivo` fica `meu\-arquivo`)

`varied`
:  Esse campo é lógico e indica se as provas serão variadas (1, ou
aleatórias) ou não (0).

`answers`
:  Este campo recebe dois valores: `show` e `hide` e serve para mostrar
ou não mostrar a solução do exercício.

## Forma de Usar

  1. Crie um Rnw com os exercícios defidos em ambientes do `probsoln`. O
     ambiente mais genérico é o `defproblem`. Veja `distr-amostral.Rnw`.
  2. Se o exercício for aleatório, você deve usar a marca `_SEED_` em
     dois lugares: no nome do exercício e no chunk antes do
     `set.seed()`. Depois disso é só exercutar `./Rnw2tex.R` no arquivo
     Rnw informando o número desejado de provas. Você pode fazer isso de
     dentro do próprio Rmd.
  3. Liste no campo `exercises` do YAML os arquivos a serem usados.
  4. Compile o documento Rmd.
