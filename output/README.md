# Project: OCR (Optical Character Recognition) 

### Output folder

The output directory contains analysis output, processed datasets, logs, or other processed things.

**ground_truth**: Documents consisted of lines with same number of tokens compared to tesseract. (After Lines alignment)

**tesseract**: Documents consisted of lines with same number of tokens compared to ground truth. (After Lines alignment)

**prediction**: Documents that predicted by our correction program. (First 10 documents only)

**ground_truth_tk**: Documents consisted of corresponding tokens with same length compared to tesseract. 
(For confusion probability)

**ground_truth_tk**: Documents consisted of corresponding tokens with same length compared to ground truth.
(For confusion probability)

**.Rdata files**: Some R ojbects that need much time to generate. We store them here and we load it directly in R code chunks wherever we need it.
