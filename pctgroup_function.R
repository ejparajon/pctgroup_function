#As the function requires the tidyverse this code chunk checks if the package is installed and if not installs it before loading.

if(!require(tidyverse)){
  install.packages("tidyverse")
  library(tidyverse)
}


# Creating the function ---------------------------------------------------

#This function enables quick data summarizing and grouping
pctgroup <- function(data,...,rd = 1) {
  dplyr::select(data,...) %>% #select the data and variables of interest
    dplyr::filter(complete.cases(.)) %>% #drop any missing data in this case the . is referring to the dataframe
    dplyr::group_by(...,.drop=FALSE) %>% #optional select a grouping variable (ignoring dropping groups that don't appear)
    dplyr::summarise(n = n()) %>% #Summarise each group down to one row to generate the number of obs 
    mutate(Percentage = round(100*n/sum(n),rd)) %>% #Creating a percentage variable based on the number of obs
    ungroup %>% 
    complete(...,fill=list(n=0,Percentage=0)) #Combined with line 15 this returns observations that do not show as zeros rather than missing
}


# Example usage ---------------------------------------------------
print(pctgroup(starwars,homeworld),n=Inf) #generating a list of character's homeworlds present in the starwars films (counts and then percentage of all homeworlds)

print(pctgroup(starwars,species,gender),n=Inf) #Are some starwars species more likely to be male or female? This also demonstrates the value of including missing observations (some species feature only one gender)


print(pctgroup(diamonds,color,cut),n=Inf) #Breakdown of types of diamond cuts according to color.
