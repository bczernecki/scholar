get_publication_link = function (id, article, morepages = TRUE) 
{
  article = as.character(article)
  url = paste0("https://scholar.google.pl/scholar?oi=bibs&hl=en&cites=", article)
  
  if(morepages){
    

  page = read_html(url)
  
  links <- page %>% html_nodes("a") %>% html_attr("href") 
  links = paste0("https://scholar.google.pl", 
         links[grep(x = links, pattern = "start")]) %>% unique()
  
  url = c(url, links)
  }
  
  
  return(url)

  
  # Extract raw data
  # wp <- xml2::read_html(url)
  # titles <- rvest::html_text(rvest::html_nodes(wp, '.gs_rt'))
  # authors <- rvest::html_text(rvest::html_nodes(wp, '.gs_a'))
  
  #  html_nodes(page, "[class = 'gs_ico_nav_current']") %>% html_attr(page, "href")
  
  
  # curl_download(url, destfile = "test.html")
  # page = read_html(x = "test.html")
  # file.edit("test.html")
  # page = html_nodes(page, "[class='gsc_oms_link']") %>% html_attr("href")
  
  #html_attr("href") -> link_to_publication
  #file.remove("test.html")
}
