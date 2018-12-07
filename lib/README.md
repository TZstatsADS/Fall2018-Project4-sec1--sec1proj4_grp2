# Project: OCR (Optical Character Recognition) 

### Code lib Folder

The lib directory contains various files with function definitions and code.

#### preprocess.R:   for lines and characters alignment

-- computing the number of lines in a given text file

-- computing the number of tokens in given text vectors.


#### confusion_prob_matrix.R:   for computation of confusion probabilit matrix

-- computing confusion number of printed letter_i given the true letter_j. (Entries of confusion number matrix.)

-- computing the number of a true letter.

-- computing the confusion number matrix to calculate confusion probability matrix.


#### detection.R:    for detection a text

-- detecting words. garbage word --> TRUE, clean word --> FALSE.

-- detecting words vectors. output TRUE/FALSE vector with names are tokens.

-- detecting files. output TRUE/FALSE vector with names are tokens.


#### LDAlist.R:   for LAD model list, which would be used in calculating topic modeling probability for a candidate word

-- getting a list consists of LDA models, when each was trained by documents other than every document in ground_truth file


#### lexicon.R:   for testing if a candidate is valid (belongs to the lexicon)

-- getting a long word vector, which is going to be stored as the lexicon.


#### lowercandidate_generate.R:  for generating possible correct words to a given typo

-- generating lower candidates of a given typo word with 2 or less letters change.


#### correction.R:   for correction a file

-- computing confusion score for a candidate word based on confusion probabilities, along with the word's best lower-upper prediction.

-- generating a DocumentTermMatrix for a given tesseract file by using those clean words in it which are detected by detection.

-- computing topic score for a candidate word based on the topic probabilities determined by clean words and word specific probabilities of all topics.

-- computing scores for candidates based on topic score and confusion score, along with the word's best lower-upper prediction.

-- correcting a word by the candidate with highest score.

-- correcting a text file.


#### evaluation.R:   for evaluation of predictions

-- computing word-wise recall. sensitive to upper case letters.

-- computing word-wise precision. sensitive to upper case letters.

-- computing character-wise recall. sensitive to upper case letters. order matters. used on token aligned text file.

-- computing character-wise precision. sensitive to upper case letters. order matters. used on token aligned text file.
