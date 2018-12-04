## Get the number of lines for each txt document
get_number_lines <- function(doc_loc){
  text <- readLines(doc_loc, warn = FALSE, encoding = "UTF-8")
  return(length(text))
}

####################### select those lines with same number of tokens.#################################################

## Next, get the number of tokens in lines of each document.
get_number_tokens <- function(line_vec){
  split_list <- strsplit(line_vec, split = " ")
  return(sapply(split_list, length))
}

####### Get index of lines which have different tokens in truth and tesseract for each document

## Get the number of tokens for each line of each documents for both ground truth and tesseract
## List: name -> name of documents; corresponding element -> numbers of tokens for lines in the document

truth_tokenNum_list <- list()
for(i in 1:length(doc_name)){
  doc <- doc_name[i]
  docloc <- paste0(truth_file_loc, doc)
  truetext_vec <- readLines(docloc, warn = FALSE, encoding = "UTF-8")
  truth_tokenNum_list[[i]] <- get_number_tokens(truetext_vec)
}
names(truth_tokenNum_list) <- doc_name

tesseract_tokenNum_list <- list()
for(i in 1:length(doc_name)){
  doc <- doc_name[i]
  docloc <- paste0(tesseract_file_loc, doc)
  tesstext_vec <- readLines(docloc, warn = FALSE, encoding = "UTF-8")
  tesseract_tokenNum_list[[i]] <- get_number_tokens(tesstext_vec)
}
names(tesseract_tokenNum_list) <- doc_name



## Get the logic which have the same number of tokens in truth and tesseract

log_tokNumEq_list <- list()
for(i in 1:length(doc_name)){
  log_tokNumEq_list[[i]] <- truth_tokenNum_list[[i]] == tesseract_tokenNum_list[[i]]
}
names(log_tokNumEq_list) <- doc_name

## Write those 88.1% lines with same number of tokens in output files.

output_loc <- "../output/"
for(i in 1:length(doc_name)){
  doc <- paste0(truth_file_loc, doc_name[i])
  text_vec_all <- readLines(doc, warn = FALSE, encoding = "UTF-8")
  ind_sameTKnum <- log_tokNumEq_list[[i]]
  text_vec <- text_vec_all[ind_sameTKnum]
  writeLines(text_vec, paste0(output_loc,"ground_truth/",doc_name[i]), useBytes = TRUE)
}

for(i in 1:length(doc_name)){
  doc <- paste0(tesseract_file_loc, doc_name[i])
  text_vec_all <- readLines(doc, warn = FALSE, encoding = "UTF-8")
  ind_sameTKnum <- log_tokNumEq_list[[i]]
  text_vec <- text_vec_all[ind_sameTKnum]
  writeLines(text_vec, paste0(output_loc,"tesseract/",doc_name[i]), useBytes = TRUE)
}

## Write those tokens with same length down in output files.
truthline_loc <- paste0(output_loc, "ground_truth/")
tessline_loc <- paste0(output_loc, "tesseract/")

for(i in 1:length(doc_name)){
  truth_text <- readLines(paste0(truthline_loc, doc_name[i]), warn = FALSE, encoding = "UTF-8")
  tess_text <- readLines(paste0(tessline_loc, doc_name[i]), warn = FALSE, encoding = "UTF-8")
  truth_strsplit_list <- strsplit(truth_text, " ")
  tess_strsplit_list <- strsplit(tess_text, " ")
  truth_letternum_list <- lapply(truth_strsplit_list, nchar)
  tess_letternum_list <- lapply(tess_strsplit_list, nchar)
  
  truetk_text <- c()
  tesstk_text <- c()
  for(j in 1:length(truth_letternum_list)){
    ind_letternumEq <- truth_letternum_list[[j]] == tess_letternum_list[[j]]
    truetk_text <- c(truetk_text, paste0(truth_strsplit_list[[j]][ind_letternumEq], collapse = ""))
    tesstk_text <- c(tesstk_text, paste0(tess_strsplit_list[[j]][ind_letternumEq], collapse = ""))
  }
  writeLines(truetk_text, paste0(output_loc,"ground_truth_tk/",doc_name[i]), useBytes = TRUE)
  writeLines(tesstk_text, paste0(output_loc,"tesseract_tk/",doc_name[i]), useBytes = TRUE)
}

