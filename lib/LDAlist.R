############ Get A list consists of LDA models, where each was trained by documents other than every document in ground_truth file

get_ldamodels <- function(file_loc, n_topics){
  file_names <- list.files(file_loc)
  lda_list <- list()
  for(i in 1:length(file_names)){
    train_names <- file_names[-i]
    
    
    
    ground_truth_df <- data_frame()
    for(j in 1:length(train_names)){
      name <- paste0(file_loc, train_names[j])
      text <- readLines(name, warn = FALSE, encoding = "UTF-8")
      text_df <- data_frame(text = text, doc = train_names[j])
      ground_truth_df <- rbind(ground_truth_df, text_df)
    }
    ground_truth_dtm <- ground_truth_df %>%
      unnest_tokens(word, text) %>%
      #anti_join(stop_words) %>%
      filter(nchar(word) > 1) %>%
      #filter( !grepl(pattern = "[0-9]", word) ) %>%
      count(doc, word) %>%
      cast_dtm(doc, word, n)
    
    lda_list[[i]] <- LDA(ground_truth_dtm, k = n_topics)
  }
  names(lda_list) <- file_names
  return(lda_list)
}