#MaAsLin2 input
#set up

rm(list=ls())
getwd()
setwd("~/Desktop/MaAsLin_Analysis/")
#dir.create("R_Maaslin_result") # Create a new directory
#setwd("R_Maaslin_result") # Change the current working directory 
#getwd() #check if directory has been successfully changed

#Load MaAsLin2 package into the R environment
library(Maaslin2)

df_input_data = read.table(file="data_mod.csv", header = TRUE, sep = ",", row.names = 1, stringsAsFactors = FALSE)
df_input_data[is.na(df_input_data)] <- 0

df_input_metadata = read.table(file = "meta_mod.csv", header = TRUE, sep = ",", row.names = 1, stringsAsFactors = FALSE)
 
 
#Running MaAsLin2

fit_data = Maaslin2(
    input_data = df_input_data, 
    input_metadata = df_input_metadata, 
    output = "demo_output_mixedModel_test", 
#    min_abundance=0, #0
    min_prevalence=0.5, #0.1
    max_significance=0.10, # 0.25
#    normalization="TSS", # TSS, CLR, CSS, NONE, TMM
    transform="LOG", #  LOG, LOGIT, AST, NONE
#	analysis_method=LM, # LM, CPLM, ZICP, NEGBIN, ZINB
   
    random_effects = c("MouseID","Cage","Sex","Parents"),
 #   fixed_effects = c(,"Cage"),
 #   random_effects = c("MouseID"),
 #   random_effects = c("Parents"),
    fixed_effects = c("Age"),
	standardize=TRUE,
	#reference=c("Pregnancy","bef")
    )
    	
