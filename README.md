---
title: "README"
author: "Dave Richards"
date: "September 27, 2015"
output: html_document
---
run_analysis.R contains a script that can be run to create a  tidy data set with the average of each variable for each activity and each subject as described in the covebook. The script assumes the Samsung data has been unzipped to directory "~/R/GetClean/project/UCI HAR dataset".   
    
The text file can be read into a data frame by running:
```{r}  
 df <- read.table("tidy_data.txt", header = TRUE)
```
  
Details of the data cleaning process can be found in the inline comments in the R script.