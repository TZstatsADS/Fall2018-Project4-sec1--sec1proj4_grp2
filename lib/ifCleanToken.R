##############################
## Garbage detection
## Ref: first three rules in the paper
##      'On Retrieving Legal Files: Shortening Documents and Weeding Out Garbage'
## Input: one word -- token
## Output: bool -- if the token is clean or not
##############################
ifCleanToken <- function(cur_token){
  now <- 1
  if_clean <- TRUE
  
  ## in order to accelerate the computation, conduct ealy stopping
  rule_list <- c("nchar(cur_token)>20",
                 #1 A string composed of more than 20 symbols is garbage
                 
                 "str_count(cur_token, pattern = '[A-Za-z0-9]') <= 0.5*nchar(cur_token)", 
                 #2 If the number of punctuation characters in a string is greater than 
                 # the number of alphanumeric characters, it is garbage
                 
                 "length(unique(strsplit(gsub('[A-Za-z0-9]','',substr(cur_token, 2, nchar(cur_token)-1)),'')[[1]]))>1", 
                 #3 Ignoring the first and last characters in a string, if there are two or more 
                 # different punctuation characters in thestring, it is garbage.
                 
                 "str_count(cur_token, pattern = '\\b[a-zA-Z0-9]*([a-zA-Z0-9])\\1\\1+[a-zA-Z0-9]*\\b') >= 1",
                 #4 If there are three or more identical characters in a row in a string, it is garbage.
                 
                 "(str_count(cur_token, pattern = '[A-Z]') < nchar(cur_token)) & (str_count(cur_token, pattern = '[A-Z]') > str_count(cur_token, pattern = '[a-z]'))",
                 #5 If the number of uppercase characters in a string is greater than the number of lowercase characters, and if the
                 # number of uppercase characters is less than the total number of characters in the string, it is garbage.
                 
                 "(str_count(cur_token, pattern = '[bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ]') > 8*str_count(cur_token, pattern = '[aeiouAEIOU]')) | (str_count(cur_token, pattern = '[aeiouAEIOU]') > 8*str_count(cur_token, pattern = '[bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ]'))",
                 #6 If all the characters in a string are alphabetic, and if the number of consonants in 
                 # the string is greater than 8 times the number of vowels in the string, or vice-versa, it is garbage.
                 
                 "(str_count(cur_token, pattern = '([aeiou]){3,}') >= 1) | (str_count(cur_token, pattern = '([bcdfghjklmnpqrstvwxyz]){4,}') >= 1)",
                 #7 If there are four or more consecutive vowels in the string or five or more consecutive consonants 
                 # in the string, it is garbage.
                 
                 "grepl('^[a-z][a-z]*[A-Z]+[a-z]*[a-z]$',cur_token)"
                 #8 If the first and last characters in a string are both lowercase and any other 
                 # character is uppercase, it is garbage.
                 ) 
                  
  while((if_clean == TRUE) & now<=length(rule_list)){
    if(eval(parse(text = rule_list[now]))){
      if_clean <- FALSE
    }
    now <- now + 1
  }
  return(if_clean)
}