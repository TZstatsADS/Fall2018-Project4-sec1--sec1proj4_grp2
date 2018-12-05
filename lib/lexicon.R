############ lexicon with punctuation #################
#using ground truth as a dictionary#############
get_trueitems <- function(dictionary_loc){
  file_names <- list.files(dictionary_loc)
  trueitems <- c()
  for(i in 1:length(file_names)){
    text <- readLines(paste0(dictionary_loc, file_names[i]), warn = FALSE, encoding = "UTF-8")
    words <- unlist(strsplit(text, split = " "))
    trueitems <- c(trueitems, words)
  }
  
  return(unique(trueitems))
}
