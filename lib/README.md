# Project: OCR (Optical Character Recognition) 

### Code lib Folder

The lib directory contains various files with function definitions and code.

preprocess.R:   for lines and characters alignment

-- computing number of lines or number of tokens in each line for each text file. 


confusion_prob_matrix.R:   for computation of confusion probabilit matrix

-- computing confusion probabilit matrix.


detection.R:    for detection a text

-- detecting words. garbage word --> TRUE, clean word --> FALSE.

-- detecting words vectors.

-- detecting files.


LDAlist.R:   for LAD model list, which would be used in calculating topic modeling probability for a candidate word

-- getting a list consists of LDA models, when each was trained by documents other than every document in ground_truth file


lexicon.R:   for testing if a candidate is valid (belongs to the lexicon)

-- getting a long word vector, which stored as lexicon.


lowercandidate_generate.R:  for generating possible correct words to a given typo

-- generating lower candidates of a given typo word with 2 or less letters change.


correction.R:   for correction a file

-- computing scores for candidates

-- correcting a word

-- correcting a text file


evaluation.R:   for evaluation of predictions

-- computing word-wise recall

-- computing word-wise precision

-- computing character-wise recall

-- computing character-wise precision
