## Get the number of lines for each txt document
get_number_lines <- function(doc_loc){
  text <- readLines(doc_loc, warn = FALSE, encoding = "UTF-8")
  return(length(text))
}


## Next, get the number of tokens in lines of each document.
get_number_tokens <- function(line_vec){
  split_list <- strsplit(line_vec, split = " ")
  return(sapply(split_list, length))
}