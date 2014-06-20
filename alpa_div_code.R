### EXPLANATION: This is a sample code for an alpha diversity loop. 
### It is currently set up to run three diversity functions.
### But you will find other functions in the code that I have put there to figure out later.
### DISCLAIMER: It is clearly a work in progress and has problems to fix

# Things to Do:

# Table 1- drop NA's
# Transpose Table1. Must keep col/row names.
# Group Comparison. T.test for each Diversity Measure.
# Produce Table with form
#   - Diversity, group1(mean/sd), group2(mean/sd), degrees of freedom, t.test stat, pvalue
#   - loop might be helpful.


# **************************************************************************** #
# ***************             Start UP Commands                *************** #
# **************************************************************************** #

rm(list=ls())
now=Sys.Date()
today=format(now, format="%d%b%y")

# **************************************************************************** #
# ***************                   Directories                *************** #
# **************************************************************************** #

#setwd("C:/Users/tomczika/Dropbox/Undergrad_Research/Angela/MIG_study/16S")
setwd("C:/Users/lemasd/Dropbox/Undergrad_Research/Angela/MIG_study/16S")

list.files()

# **************************************************************************** #
# ***************                   Libraries                  *************** #
# **************************************************************************** #

#install.packages("samplesize", dependencies = FALSE)
#install.packages("vegan")
library("samplesize")
library("vegan")

# **************************************************************************** #
# ***************                 Import Data                  *************** #
# **************************************************************************** #

#Count data
otu.raw <- read.csv(file="MIG_infant8_Phylum_OTU_Count_19June14.csv",na.string="", 
                    header=T)
str(otu.raw)
#Normalized Data
otu.normed<- read.csv(file="MIG_infant8_Phylum_OTU_28May14.csv",na.string="", header=T)
str(otu.normed)
# bacteria need to be characters not factors

# **************************************************************************** #
# ***************           Create Empty Data.Frame            *************** #
# **************************************************************************** #
TABLE1<-data.frame(OTU_Name=character(),
                   shannon=numeric(),
                   simpson=numeric(),
                   invsimpson=numeric(),
                   #rrarefy=numeric(),
                   stringsAsFactors=FALSE); TABLE1 

# **************************************************************************** #
# ***************                 Loop Index                   *************** #
# **************************************************************************** #

index=names(otu.raw);index; str(otu.raw)
myIndex<-length(index);myIndex 

# **************************************************************************** #
# ***************                 Start Loop                   *************** #
# **************************************************************************** #
for (i in 2:myIndex)
{ 
  #Column Index
  col=index[i]
  names(otu.raw)
  
  
  #Functions
  shannon= diversity(otu.raw[,col], index = "shannon", MARGIN = 1, base = exp(1))
  simpson= diversity(otu.raw[,col], index = "simpson", MARGIN = 1, base = exp(1))
  invsimpson= diversity(otu.raw[,col], index = "invsimpson", MARGIN = 1, base = exp(1))
  ###The follow functions require additonal imput. 
  ### Set sample:Subsample size for rarefying community, either a single value or a vector.
  #sample=2
  #rrarefy= rrarefy(otu.raw$DLFP34, sample)
  #rarefy(otu.raw$DLFP34, sample, se = FALSE, MARGIN = 1)
  #drarefy(otu.raw$DLFP34, sample)
  #fisher.alpha(otu.raw$DLFP34, MARGIN = 1)
  #specpool(otu.raw$DLFP34)
  #estimateR(otu.raw$DLFP34)

  # Bind variables
  continuous_block=cbind(col, shannon, simpson,invsimpson);continuous_block
   
  
  # Add to data.frame
  TABLE1[i,1]=col
  TABLE1[i,2]=shannon
  TABLE1[i,3]=simpson
  TABLE1[i,4]=invsimpson
  #TABLE1[i,5]=rrarefy

} # End of Loop
TABLE1

# **************************************************************************** #
# ***************                 Test For Differences         *************** #
# **************************************************************************** #














