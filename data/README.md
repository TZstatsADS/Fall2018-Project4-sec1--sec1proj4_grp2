# Project: OCR (Optical Character Recognition) 

### Data folder

The data directory contains data used in the analysis. This is treated as read only; in paricular the R/python files are never allowed to write to the files in here. Depending on the project, these might be csv files, a database, and the directory itself may have subdirectories.

In this project, there are two subfolders -- ground_truth and tesseract. Each folder contains 100 text files with same file names correspondingly.

Subfolders ground_truth and tesseract have been aligned on lines. (Corresponding text files have same number of lines.)

We add one more subfolders -- prediction. Folder prediction contains typo-corrected text files of first 10 text files of tesseract with same file names correspondingly.
