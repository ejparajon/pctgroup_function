#As the function requires the tidyverse this code chunk checks if the package is installed and if not installs it before loading.

if(!require(tidyverse)){
  install.packages("tidyverse")
  library(tidyverse)
}

# Creating the function ---------------------------------------------------

#This function enables quick summarizing and grouping of catagorical variables
pctgroup <- function(data,...,rd = 1) { #rd sets rounding in this case to 1 digit after decimal
  dplyr::select(data,...) %>% #select the data and variables of interest
    dplyr::filter(complete.cases(.)) %>% #drop any missing data in this case the . is referring to the data
    dplyr::group_by(...,.drop=FALSE) %>% #Adds the option to select a grouping variable (ignoring dropping groups that don't appear)
    dplyr::summarise(n = n()) %>% #Summarise each group down to one row to generate the number of obs 
    mutate(Percentage = round(100*n/sum(n),rd)) %>% #Creating a percentage variable based on the number of obs
    ungroup %>% 
    complete(...,fill=list(n=0,Percentage=0)) #Combined with line 15 this returns observations that are options in the underlying data but that do not show up as zeros in the final output
}


# Example usage ---------------------------------------------------
#Generic usage: pctgroup(data,variable)
#The first variable listed is the grouping variable. 

#1.generating a list of character's homeworlds present in the starwars films (counts and then percentage of all homeworlds)
print(pctgroup(starwars,homeworld),n=Inf) 

#1.1 can also add a call to arrange() to order the output
print(pctgroup(starwars,homeworld),n=Inf) %>% 
  arrange(desc(Percentage))

#2. Are some starwars species more likely to be male or female? 
#This also demonstrates the value of including missing observations (some species feature only one gender)
print(pctgroup(starwars,species,gender),n=Inf) 

#3.Breakdown of types of diamond cuts according to color.
print(pctgroup(diamonds,color,cut),n=Inf)
