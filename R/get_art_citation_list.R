get_art_citation_list = function(url){
  
  citation_list = data.frame(titles = NA, authors = NA)
  
  for (i in 1:length(url)){
    
      # Extract raw data
      wp <- xml2::read_html(url[i])
      titles <- rvest::html_text(rvest::html_nodes(wp, '.gs_rt'))
      authors <- rvest::html_text(rvest::html_nodes(wp, '.gs_a'))
      
      if(length(titles) > length(authors)) {
        titles = titles[length(authors)]
      }
      
      # extra cleaning
      titles = trimws(sub("\\[.*]", "", as.character(titles)))
      df = data.frame(titles, authors)
      citation_list = rbind.data.frame(citation_list, df)
  }
  citation_list = na.omit(citation_list)
  return(citation_list)
}
