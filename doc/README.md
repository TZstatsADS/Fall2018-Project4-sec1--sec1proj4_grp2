# Project: OCR (Optical Character Recognition) 

### Doc folder

The doc directory contains the report or presentation files.

In main.Rmd, most chunks are set to eval = FALSE. You could just run those chunks without setting eval = FALSE to regenerate text results since all required data has been stored and loaded as Rdata files in output. Or you could run chunks with setting eval = FALSE to regenerate these Rdata file, which may take much time.

In main.Rmd, the last chunk is about using iteration to improve our correction. This chunk is fully functionable but you may not want to run it because it would take very long time but the improvement of iteration is quite little.
