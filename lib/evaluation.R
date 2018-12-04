########### Coerrect function for a tesseract file.##############################################
eval_correct_file <- function(docname, detection_list_eval){
  text_info <- detection_list_eval[[docname]]
  words_vec <- names(text_info)
  
  for(i in 1:length(words_vec)){
    if(text_info[i]){
      words_vec[i] <- correct_word(words_vec[i], docname)
    }
    #print(c(docname, i))
  }
  correct_text <- paste0(words_vec, collapse = " ")
  return(correct_text)
}

########### Word-wised evaluation.############

recall_words <- function(ground_truth_loc, prediction_loc){
  truth_files <- list.files(ground_truth_loc)
  pred_files <- list.files(prediction_loc)
  files <- intersect(pred_files, truth_files)
  correctnum <- 0
  totaltruthnum <- 0
  for(i in 1:length(files)){
    truth_text <- readLines(paste0(ground_truth_loc, files[i]), warn = FALSE, encoding = "UTF-8")
    pred_text <- readLines(paste0(prediction_loc, files[i]), warn = FALSE, encoding = "UTF-8")
    truth_vec <- strsplit(paste(truth_text, collapse = " "), split = " ")[[1]]
    pred_vec <- strsplit(paste(pred_text, collapse = " "), split = " ")[[1]]
    intersect_vec <- vecsets::vintersect(truth_vec, pred_vec)
    correctnum <- correctnum + length(intersect_vec)
    totaltruthnum <- totaltruthnum + length(truth_vec)
  }
  return(correctnum/totaltruthnum)
}

precision_words <- function(ground_truth_loc, prediction_loc, tesseract_loc){
  truth_files <- list.files(ground_truth_loc)
  pred_files <- list.files(prediction_loc)
  files <- intersect(pred_files, truth_files)
  correctnum <- 0
  totalOCRnum <- 0
  for(i in 1:length(files)){
    truth_text <- readLines(paste0(ground_truth_loc, files[i]), warn = FALSE, encoding = "UTF-8")
    pred_text <- readLines(paste0(prediction_loc, files[i]), warn = FALSE, encoding = "UTF-8")
    truth_vec <- strsplit(paste(truth_text, collapse = " "), split = " ")[[1]]
    pred_vec <- strsplit(paste(pred_text, collapse = " "), split = " ")[[1]]
    intersect_vec <- vecsets::vintersect(truth_vec, pred_vec)
    correctnum <- correctnum + length(intersect_vec)
    
    tess_text <- readLines(paste0(tesseract_loc, files[i]), warn = FALSE, encoding = "UTF-8")
    tess_vec <- strsplit(paste(tess_text, collapse = " "), split = " ")[[1]]
    totalOCRnum <- totalOCRnum + length(tess_vec)
  }
  return(correctnum/totalOCRnum)
}

############ character-wise evaluation.######################

recall_chars <- function(ground_truth_loc, prediction_loc){
  truth_files <- list.files(ground_truth_loc)
  pred_files <- list.files(prediction_loc)
  files <- intersect(pred_files, truth_files)
  correct_char <- 0
  total_truth_char <- 0
  for(i in 1:length(files)){
    truth_text <- readLines(paste0(ground_truth_loc, files[i]), warn = FALSE, encoding = "UTF-8")
    pred_text <- readLines(paste0(prediction_loc, files[i]), warn = FALSE, encoding = "UTF-8")
    truth_vec <- strsplit(paste(truth_text, collapse = " "), split = " ")[[1]]
    pred_vec <- strsplit(paste(pred_text, collapse = " "), split = " ")[[1]]
    stopifnot(length(truth_vec) == length(pred_vec))
    for(j in 1:length(truth_vec)){
      cur_truthword <- truth_vec[j]
      cur_predword <- pred_vec[j]
      cur_truthletter <- strsplit(cur_truthword, split = "")[[1]]
      cur_predletter <- strsplit(cur_predword, split = "")[[1]]
      if(length(cur_predletter) == length(cur_truthletter)){
        correct_char <- correct_char + sum(cur_predletter == cur_truthletter)
      }
      else{
        correct_char <- correct_char + length(vecsets::vintersect(cur_truthletter, cur_predletter))
      }
      total_truth_char <- total_truth_char + length(cur_truthletter)
    }
  }
  return(correct_char/total_truth_char)
}

precision_chars <- function(ground_truth_loc, prediction_loc, tesseract_loc){
  truth_files <- list.files(ground_truth_loc)
  pred_files <- list.files(prediction_loc)
  
  files <- intersect(pred_files, truth_files)
  correct_char <- 0
  total_ocr_char <- 0
  for(i in 1:length(files)){
    truth_text <- readLines(paste0(ground_truth_loc, files[i]), warn = FALSE, encoding = "UTF-8")
    pred_text <- readLines(paste0(prediction_loc, files[i]), warn = FALSE, encoding = "UTF-8")
    tess_text <- readLines(paste0(tesseract_loc, files[i]), warn = FALSE, encoding = "UTF-8")
    
    truth_vec <- strsplit(paste(truth_text, collapse = " "), split = " ")[[1]]
    pred_vec <- strsplit(paste(pred_text, collapse = " "), split = " ")[[1]]
    tess_vec <- strsplit(paste(tess_text, collapse = " "), split = " ")[[1]]
    
    stopifnot(length(truth_vec) == length(pred_vec) & length(pred_vec) == length(tess_vec))
    
    for(j in 1:length(truth_vec)){
      cur_truthword <- truth_vec[j]
      cur_predword <- pred_vec[j]
      cur_truthletter <- strsplit(cur_truthword, split = "")[[1]]
      cur_predletter <- strsplit(cur_predword, split = "")[[1]]
      if(length(cur_predletter) == length(cur_truthletter)){
        correct_char <- correct_char + sum(cur_predletter == cur_truthletter)
      }
      else{
        correct_char <- correct_char + length(vecsets::vintersect(cur_truthletter, cur_predletter))
      }
      total_ocr_char <- total_ocr_char + nchar(tess_vec[j])
    }
  }
  return(correct_char/total_ocr_char)
}
