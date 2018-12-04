##input: an word
##output: a vector of strings, which are alphabetic candidates

#file_loc <- "D:/Github/Fall2018-Project4-sec1--sec1proj4_grp2/data/"

replace <- function(letter, word, position){
  stopifnot(position <= nchar(word) & position >= 1)
  word_vec <- strsplit(word, split = "")[[1]]
  word_vec[position]  <- letter
  return(paste0(word_vec, collapse = ""))
}

replace2 <- function(letter1, letter2, word, position1, position2){
  stopifnot(position1 <= nchar(word) & position1 >= 1)
  stopifnot(position2 <= nchar(word) & position2 >= 1)
  word_vec <- strsplit(word, split = "")[[1]]
  word_vec[position1]  <- letter1
  word_vec[position2]  <- letter2
  return(paste0(word_vec, collapse = ""))
}


lowercandidate_generate <- function(typoword, lexicon){ ## use ground truth as dictionary
  letterlist <- c("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z")
  typoword <- tolower(typoword)
  n <- nchar(typoword)
  wordvector <- c()
  
  if(grepl(pattern = "[A-Za-z0-9]", typoword)){
    wordvector <- c(typoword)
  }
  for(i in 1:n){
    for(letter in letterlist){
      candidate <- replace(letter, typoword, i)
      if(candidate %in% lexicon){
        wordvector <- c(wordvector, candidate)
      }
    }
  }
  
  for(i in 1:(n-1)){
    for(j in (i+1):n){
      for(letter1 in letterlist){
        for(letter2 in letterlist){
          candidate <- replace2(letter1, letter2, typoword, i, j)
          if(candidate %in% lexicon){
            wordvector <- c(wordvector, candidate)
          }
        }
      }
    }
  }
  
  return(unique(wordvector))
}
