############ lexicon without punctuation #################
get_dictionary <- function(dictionary_loc){
  file_names <- list.files(dictionary_loc)
  ground_truth_df <- data_frame()
  
  for(i in 1:length(file_names)){
    name <- paste0(dictionary_loc, file_names[i])
    text <- readLines(name, warn = FALSE, encoding = "UTF-8")
    text_df <- data_frame(text = text, doc = file_names[i])
    ground_truth_df <- rbind(ground_truth_df, text_df)
  }
  ground_truth_tk <- ground_truth_df %>%
    unnest_tokens(word, text) %>%
    filter(nchar(word) > 1)
  return(unique(ground_truth_tk$word))
}

############ lexicon with punctuation #################
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
