##input: a token; output: TRUE or FALSE. TRUE -> token is garbage; FALSE -> token is not garbage
library(stringr)
detect_word <- function(token){
  now <- 1
  if_garbage <- FALSE
  rule_list <- c("nchar(token) > 20",
                 "(nchar(token) > 1) & (str_count(token, pattern = '[A-Za-z0-9]') <= 0.5 *nchar(token))",
                 "length(unique(strsplit(gsub('[A-Za-z0-9]','',substr(token, 2, nchar(token)-1)),'')[[1]])) > 1",
                 "grepl(pattern = '(.)\\1{3}', token)",
                 "str_count(token, pattern = '[A-Z]') > str_count(token, pattern = '[a-z]') & (str_count(token, pattern = '[A-Z]') < nchar(token))",
                 "(nchar(token) > 1) & !grepl(pattern = '[^A-Za-z]', token) & (str_count(token, pattern = '[^aeiouAEIOU]') > 8/9 * nchar(token) | str_count(token, pattern = '[^aeiouAEIOU]') < 1/9 * nchar(token))",
                 "grepl(pattern = '[aeiouAEIOU]{4,}', token) | grepl(pattern = '[^aeiouAEIOU]{5,}', token)",
                 "grepl(pattern = '[A-Z]', token) & grepl('[a-z]', substr(token, 1, 1)) & grepl('[a-z]', substr(token, nchar(token), nchar(token)))",
                 "grepl(pattern = '[^aeiouAEIOU]l', token)",
                 "grepl(pattern = '[0-9][a-zA-Z]', substr(token,1,2))"
                 )
  while(if_garbage == FALSE & now <= length(rule_list)){
    if(eval(parse(text = rule_list[now]))){
      if_garbage <- TRUE
    }
    now <- now + 1
  }
  return(if_garbage)
}

##input: a word vector; outpu: T/F vector for the word vector
detect_wordvec <- function(wordvec){
  return(sapply(wordvec, detect_word))
}



##input: a single file location; output: list of T/F vector. Each element is a vector of T/F for tokens detection on that line
##(TRUE -> token is garbage; FALSE -> token is not garbage)

detect_file <- function(single_file_loc){
  text <- readLines(single_file_loc, warn = FALSE, encoding = "UTF-8")
  ############ including punctuation version ###########
  token_list <- strsplit(text, split = " ")
  output_list <- lapply(token_list, detect_wordvec)
  
  output_vec <- c()
  for(i in 1:length(output_list)){
    output_vec <- c(output_vec, output_list[[i]])
  }
  return(output_vec)
}

