################################################################################

#input: a candidate word, output: probability part from confusion

ConfusionScore_prob4candidate <- function(candidate, ocr){ ##here ocr doesn't include letters otherthan those in confusion prob matrix
  stopifnot(nchar(candidate) ==  nchar(ocr))
  n <- nchar(ocr)
  score <- 1
  lu_info <- c() # if lower -> true, if upper -> false
  for(i in 1:n){
    l_ocr <- substr(ocr,i,i)
    l_candi <- substr(candidate,i,i)
    if( !l_ocr %in% letterlist ){
      lu_info <- c(lu_info, TRUE)
      next
    }
    if(confusion_prob_mat[l_ocr,l_candi] < confusion_prob_mat[l_ocr,toupper(l_candi)]){
      prob <- confusion_prob_mat[l_ocr,toupper(l_candi)]
      lu_info <- c(lu_info, FALSE)
    }
    else{
      prob <- confusion_prob_mat[l_ocr,l_candi]
      lu_info <- c(lu_info, TRUE)
    }
    score <- score*prob
  }
  return(list(lu_info = lu_info, prob = score))
}

#########################################################################################
##input: a document name
##output: a documentTermmatrix made by corrected recognized words of the input document

correct_dtm <- function(doc_name){
  #names <- names(detection_list)
  #ind <- which(doc_name == names)
  info <- detection_list[[doc_name]]
  
  words <- names(info)
  correct_words <- words[!info]
  correct_text <- paste0(correct_words, collapse = " ")
  text_df <- data_frame(text = correct_text, doc = doc_name)
  dtm <- text_df %>% 
    unnest_tokens(word, text) %>%
    filter(nchar(word) > 1) %>%
    count(doc, word) %>%
    cast_dtm(doc, word, n)
  
  return(dtm)
}
################################################################################################


# the candidate is a correction for a typo of file doc.name
# the test_dtm is the dtm made from corrected recognized words of file doc.name  ???????????????????????????????????

TopicScore_prob4candidate <- function(candidate, doc.name, test_dtm){
  cur_lda <- lda_list[[doc.name]]
  
  cur_topics_prob <- posterior(cur_lda, test_dtm)$topics
  
  topic_term_prob_mat <- tidy(cur_lda, matrix = "beta")
  
  # deal when candidate has punctuation. #############
  candidate_df <- data_frame(text = candidate)
  clean_candidate_tb <- unnest_tokens(candidate_df, word, text)
  len <- rep(0, nrow(clean_candidate_tb))
  for(i in 1:length(len)){
    len[i] <- nchar(clean_candidate_tb[i,])
  }
  clean_candidate <- clean_candidate_tb[which.max(len),1][[1]]
  candidate_mat <- topic_term_prob_mat %>% filter(term == clean_candidate)
  #candidate_mat <- topic_term_prob_mat %>% filter(term == candidate)
  return(sum(candidate_mat$beta * cur_topics_prob))
}

###### COMPUTE the score of a candidate and its lower-upper info, given OCR typo and single file name which the typo belongs to ########

score_candidate <- function(candidate, ocr, doc.name, test_dtm){
  confusion_part <- ConfusionScore_prob4candidate(candidate, ocr)
  topic_part <- TopicScore_prob4candidate(candidate, doc.name, test_dtm)
  score <- 1000 * confusion_part$prob * topic_part
  lu_info <- confusion_part$lu_info
  return(list(score = score, lu_info = lu_info))
}

########## Correct function for one typo word.###################################################
correct_word <- function(ocrword, doc){
  candidates <- lowercandidate_generate(ocrword, lexicon)
  test_dtm <- correct_dtm(doc)
  scores <- rep(0, length(candidates))
  
  lu_infos <- list()
  for(i in 1:length(candidates)){
    cur_info <- score_candidate(candidates[i], ocrword, doc, test_dtm)
    scores[i] <- cur_info$score
    lu_infos[[i]] <- cur_info$lu_info
  }
  lowercandidate_letters <- strsplit(candidates[which.max(scores)], split = "")[[1]]
  uppercandidate_letters <- toupper(lowercandidate_letters)
  lu_info <- lu_infos[[which.max(scores)]]
  cor_letters <- ifelse(lu_info, lowercandidate_letters, uppercandidate_letters)
  return(paste0(cor_letters, collapse = ""))
}
#################################################################################################

########### Coerrect function for a tesseract file.##############################################
correct_file <- function(docname, detection_list){
  text_info <- detection_list[[docname]]
  words_vec <- names(text_info)
  
  for(i in 1:length(words_vec)){
    if(text_info[i]){
      words_vec[i] <- correct_word(words_vec[i], docname)
    }
  }
  correct_text <- paste0(words_vec, collapse = " ")
  return(correct_text)
}
