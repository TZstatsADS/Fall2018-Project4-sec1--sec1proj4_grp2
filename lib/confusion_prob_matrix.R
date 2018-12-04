##input truth text location, tesserat text location
##output confusion probability matrix

compute_num_confusion <- function(trueletter, printletter, truth_tk_loc, tess_tk_loc){
  file_names <- list.files(truth_tk_loc)
  sum_confusion <- 0
  for(i in 1:length(file_names)){
    truth <- readLines(paste0(truth_tk_loc, file_names[i]), warn = FALSE, encoding = "UTF-8")
    tess <- readLines(paste0(tess_tk_loc, file_names[i]), warn = FALSE, encoding = "UTF-8")
    truthtext <- paste0(truth, collapse = "")
    tesstext <- paste0(tess, collapse = "")
    stopifnot(nchar(truthtext) == nchar(tesstext))
    #get all locations of the true letter and the total number of trueletters
    position <- str_locate_all(truthtext, trueletter)[[1]]
    if(nrow(position) > 0){
      #count how many printletters are there on those locations of the true letter
      count <- sum(str_sub(tesstext, start = position[,1], end = position[,1]) == printletter)
      sum_confusion <- sum_confusion + count
    }
  }
  return(sum_confusion)
}



compute_num_trueletter <- function(trueletter, truth_tk_loc){
  file_names <- list.files(truth_tk_loc)
  total <- 0
  for(i in 1:length(file_names)){
    truth <- readLines(paste0(truth_tk_loc, file_names[i]), warn = FALSE, encoding = "UTF-8")
    truthtext <- paste0(truth, collapse = "")
    #get all locations of the true letter and the total number of trueletters
    position <- str_locate_all(truthtext, trueletter)[[1]]
    total <- total + nrow(position)
  }
  return(total)
}


confusion_num_matrix <- function(truthtk_loc, tesstk_loc){
  mat <- matrix(0, nrow = d, ncol = d)
  for(i in 1:d){
    for(j in 1:d){
      mat[i,j] <- compute_num_confusion(letterlist[j], letterlist[i], truth_tk_loc = truthtk_loc, tess_tk_loc = tesstk_loc)
    }
  }
  return(mat)
}
