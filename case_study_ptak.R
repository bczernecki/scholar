library(scholar)
## Define the id for me:
id <- 'aENV-QsAAAAJ'

## Get his profile
l <- get_profile(id)

## Print his name and affliation
l$name

p <- get_publications(id, pagesize = 100)
# get rid of non-cited publications
p = p[p$cites>0,]
head(p, 3)


source("R/get_publication_link.R")
source("R/get_art_citation_list.R")
library(dplyr)
library(xml2)
library(rvest)
library(stringi)
library(stringr)
library(curl)

head(p)

p$autocytowania = NA

for (j in 1:nrow(p)){

  print(j)
  
  morepages = ifelse(p$cites[j]>10, TRUE, FALSE)
  links = get_publication_link(id, article = as.character(p$cid[j]), morepages = morepages)
  a = get_art_citation_list(links)

# ile razy NA PEWNO bylo autocytowanie?
  ind   = which(grepl(x = tolower(a$authors), pattern = "ptak"))
  length(ind)

# a ile razy tytul sie powtarza?
  cytowane =  tolower(a$titles)
  #tolower(iconv(a$titles, from = 'UTF-8', to = 'ASCII//TRANSLIT')) #%>% str_replace_all(., "[^[:alnum:]]", " ")
  baza = tolower(p$title)
  p$autocytowania[j] = length(unique(c(ind, which(cytowane %in% baza))))
}
