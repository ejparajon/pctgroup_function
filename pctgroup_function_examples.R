# Calling function --------------------------------------------------------
source("pctgroup_function.R")


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
