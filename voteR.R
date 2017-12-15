#### voteR ####

# Remove all objects from global enviornmen
rm(list = ls())

# Set up working directory
setwd("~/R/voteR")

# Set options
getOption("max.print")

# Load required packages
library(dplyr)
library(glm2)
library(vote)
library(ggplot2)
library(gmodels)
library(RColorBrewer)
library(stringr)
library(tidyr)

### WHAT SHOULD I DO WITH GENDER? USE 1, 0 FOR MALE FEMALE, OR SHOULD I USE M/F OR MALE/FEMALE

#### IMPORT DATA SETS ####

# Length of Time to load files: start
startTime <- as.numeric(Sys.time())

# Loop to read in eight csv files "Registered_Voters_List_Part1" through "..._Part8"
fileNames <- 1:8
voters <- NULL
container <- NULL

for (i in 1:length(fileNames)) {
  container <-
    read.csv(
      paste("~/R/voteR/Registered_Voters_List_Part", i, ".csv", sep = ""),
      stringsAsFactors = F
    )
  
  voters <- rbind(container, voters)
}

head(voters)

# End time for loop import
endTime <- as.numeric(Sys.time())
# Total Length of Time to Load Files:
totalTime <-
  (endTime - startTime) / 60 # Format to read total time in minutes and seconds
print(totalTime)

#### DATA CLEANING & FORMATTING ####

# Format dates to comply with following format: YYYY/MM/DD
voters$REGISTRATION_DATE <-
  as.Date(voters$REGISTRATION_DATE, format = "%m/%d/%y")
voters$PARTY_AFFILIATION_DATE <-
  as.Date(voters$PARTY_AFFILIATION_DATE, format = "%m/%d/%y")
voters$EFFECTIVE_DATE <-
  as.Date(voters$EFFECTIVE_DATE, format = "%m/%d/%y")
voters

# Remove all formatting from 'PHONE_NUM' column
voters$PHONE_NUM <-
  gsub("", NA, as.numeric(voters$PHONE_NUM)) # Replace empty cells with "NA"
voters$PHONE_NUM <-
  gsub("-", "", voters$PHONE_NUM) # Remove hypens (-)
voters$PHONE_NUM <-
  gsub("(", "", voters$PHONE_NUM, fixed = T) # Remove left parenthesis
voters$PHONE_NUM <-
  gsub(")", "", voters$PHONE_NUM, fixed = T) # Remove right parenthesis
voters$PHONE_NUM <-
  gsub(".", "", voters$PHONE_NUM, fixed = T) # Remove full-stop (.)


#### LIBERTARIAN ("LBR") BOULDER COUNTY REGISTERED VOTERS ####


#### MASTER BOULDER COUNTY VOTERS DATA SET ####

boulderCoVoters <- filter(voters, COUNTY == "Boulder")
nrow(boulderCoVoters)
head(boulderCoVoters)

boulderCoVoters <- boulderCoVoters[, c(
  "VOTER_ID",
  "VOTER_NAME",
  "STATUS_CODE",
  "REGISTRATION_DATE",
  "BIRTH_YEAR",
  "GENDER",
  "PARTY",
  "PARTY_AFFILIATION_DATE",
  "PHONE_NUM",
  "ADDRESS_LIBRARY_ID",
  "RESIDENTIAL_ADDRESS",
  "RESIDENTIAL_CITY",
  "CONGRESSIONAL",
  "STATE_HOUSE",
  "STATE_SENATE"
)]
str(boulderCoVoters)
head(boulderCoVoters)
write.csv(boulderCoVoters, file = "/Users/thomasapepperz/Documents/Workspace/bc_voters.csv")

# Master lpbc dataset || Extract all records that match "Boulder" for COUNTY & "LBR" for PARTY
votersLBR <-
  filter(voters, COUNTY == "Boulder", PARTY == 'LBR')
nrow(votersLBR)

# Trimmed lpbc dataset

votersLBR <- votersLBR[, c(
  "VOTER_ID",
  "VOTER_NAME",
  "COUNTY",
  "STATUS_CODE",
  "EFFECTIVE_DATE",
  "REGISTRATION_DATE",
  "BIRTH_YEAR",
  "GENDER",
  "PARTY",
  "PARTY_AFFILIATION_DATE",
  "PHONE_NUM",
  "RESIDENTIAL_ADDRESS",
  "RESIDENTIAL_CITY",
  "CONGRESSIONAL",
  "STATE_HOUSE",
  "STATE_SENATE"
)]

#### REGISTERED LBRs in LONGMONT ####

lpbc_longmont <-
  filter(voters,
         COUNTY == "Boulder",
         PARTY == 'LBR',
         RESIDENTIAL_CITY == "LONGMONT") #Use dplyr package and filter() function to aggregate based on criteria
nrow(lpbc_longmont)
lpbc_longmont

str(lpbc_longmont)

lpbc_longmont_solicit <- lpbc_longmont[, c(
  "VOTER_ID",
  "VOTER_NAME",
  "FIRST_NAME",
  "LAST_NAME",
  "PARTY_AFFILIATION_DATE",
  "STATUS",
  "STATUS_REASON",
  "EFFECTIVE_DATE",
  "REGISTRATION_DATE",
  "BIRTH_YEAR",
  "GENDER",
  "PHONE_NUM",
  "RESIDENTIAL_ADDRESS",
  "RESIDENTIAL_CITY",
  "RESIDENTIAL_ZIP_CODE",
  "RESIDENTIAL_ZIP_PLUS",
  "CONGRESSIONAL",
  "STATE_HOUSE",
  "STATE_SENATE"
)]
head(lpbc_longmont_solicit)
nrow(lpbc_longmont_solicit)

##### LPBC LONGMONT VOTERS WITH PHONE NUMBERS #####
lpbc_longmont_solicit_phone <-
  subset(lpbc_longmont_solicit, PHONE_NUM != "NA")
print(lpbc_longmont_solicit_phone)
nrow(lpbc_longmont_solicit_phone)
write.csv(lpbc_longmont_solicit_phone, file = "~/R/voteR/lpbc_longmont_solicit_phone.csv")


# Write bc_voters csv
# write lpbc_voters csv
# write lpbc_voters_recentReg
# write lpbc_voters_18_30
lpbc_voters_18_30 <-
  subset(lpbc_longmont_solicit,
         lpbc_longmont_solicit$BIRTH_YEAR >= 1987)

# write lpbc_voters_30-40s.integer(format(Sys.Date(), "%Y")))
# write lpbc_voters_50_60
# write lpbc_voters_60_above
# write lpbc_voters_men
# write lpbc_voters_women

# duplicate for UAF voters
# duplicate for Republican voters

#create datbase of LPBC people we've contacted

#### UNAFFILIATED ("UAF") BOULDER COUNTY REGISTERED VOTERS ####

votersUAF <- filter(voters, COUNTY == "Boulder", PARTY == 'UAF')

votersUAF <- votersUAF[, c(
  "VOTER_ID",
  "VOTER_NAME",
  "COUNTY",
  "STATUS_CODE",
  "EFFECTIVE_DATE",
  "REGISTRATION_DATE",
  "BIRTH_YEAR",
  "GENDER",
  "PARTY",
  "PARTY_AFFILIATION_DATE",
  "PHONE_NUM",
  "RESIDENTIAL_ADDRESS",
  "RESIDENTIAL_CITY",
  "CONGRESSIONAL",
  "STATE_HOUSE",
  "STATE_SENATE"
)]
nrow(uafbc_voters)
head(uafbc_voters)
tail(uafbc_voters)

#### REPUBLICAN ("REP") BOULDER COUNTY REGISTERED VOTERS ####

repbc_voters <- filter(voters, COUNTY == "Boulder", PARTY == 'REP')
repbc_voters <- repbc_voters[, c(
  "VOTER_ID",
  "VOTER_NAME",
  "COUNTY",
  "STATUS_CODE",
  "EFFECTIVE_DATE",
  "REGISTRATION_DATE",
  "BIRTH_YEAR",
  "GENDER",
  "PARTY",
  "PARTY_AFFILIATION_DATE",
  "PHONE_NUM",
  "RESIDENTIAL_ADDRESS",
  "RESIDENTIAL_CITY",
  "CONGRESSIONAL",
  "STATE_HOUSE",
  "STATE_SENATE"
)]

nrow(repbc_voters)
head(repbc_voters)
tail(repbc_voters)

#Rename column names
#do some basic summaries.
#median mean age, percentage of women, percentage of men, break down by congres, state and senate,
#create new column age, where by subtracts

#### TURNOUT BY GENDER ####
#gender.turnout <- ddply(vf,"gender",function(x) { data.frame(total=nrow(x),turnout=c(sum(x$g2010.v),sum(x$g2008.v)),election=c("2010","2008")) })
#qplot(gender,turnout / total, data=gender.turnout, geom="histogram", stat="identity",fill=election,position="dodge", main="Turnout in 2010 vs 2008 Wake County, by Gender") + scale_fill_brewer(name="Election cycle",pal="Set1")

#VOTER STATUS
#CrossTable(vf$status,prop.c=F,prop.chisq=F,format="SPSS",max.width=10)

# PARTY AFFILIATION
#CrossTable(vf$party,prop.c=F,prop.chisq=F,format="SPSS",max.width=10)






