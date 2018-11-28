# Project: OCR (Optical Character Recognition) 

![image](figs/intro.png)

### [Full Project Description](doc/project4_desc.md)

Term: Fall 2018

+ Team #2
+ Team members
	+ Ghada Jerfel 
	+ Peilin Li
	+ Xiaoyi Li
	+ Hengyang Lin
	+ Zhibo Zhou

+ Project summary: In this project, we created an OCR post-processing procedure to enhance Tesseract OCR output. There are four parts in our project. The first one is Data clearning, we removed the punctuation and number for each files and compared with ground -truths by rows. The next part is Error detection, there are 8 rules that we used as our algorithm based on paper D1 section 2.2. The third part is Error Correction. We first propose candidates for correct word, next we compute a score for each candidate, last we correct the word into one that with highest scores. The final step is performance measurement.
	
**Contribution statement**: 
+ project leader
  + Hengyang Lin: Designed and organized the structure of whole project. Build "Error detection" part and "Error correction" part. Searched different kinds of paper that relate to this project
  
+ Major contributor:
  + Zhibo Zhou : Designed and wrote "Error Detection" part and "Data clearning" part. Searched different kinds of papers that       related to this project and draw the ppt for presentation.
  + Peilin Li : Designed and wrote "Error Detection" part and "Data clearning" part. Searched different kinds of papers on those two parts. 
  
+Equal contribution：
  + Ghada Jerfel : Designed and wrote "Performance Measurement" and edited the readme file.
  + Xiaoyi Li: Designed and wrote "Performance Measurement" and edited the readme file.
  


Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is orgarnized as follows.

```
proj/
├── lib/
├── data/
├── doc/
├── figs/
└── output/
```

Please see each subfolder for a README file.
