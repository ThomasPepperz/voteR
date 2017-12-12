### voteR
A Package & Dataset for Voter Analysis in the R Statistical Language

## SOURCE & DESCRIPTION OF DATA SETS

Click "1 April 2017" from http://coloradovoters.info/download.html || Direct to downloads: http://coloradovoters.info/downloads/20170401/ ||parent site: http://coloradovoters.info

Website offers twelve (12) groups of voter registration datasets '1 May 2013' to '1 April 2017' (as of August 1, 2017)

Each of the twelve (12) groups of voter registration datasets comprise eight (8) voter-related files in addition to three (3) metadata files containing up to ~500,000 records and 55 columns each)

The eight files are compressed .zip folders containing  .txt formatted files

The three (3) metadata files are titled "Public EX-003-File Layout" (.xlsx), "README FILE_EX-003" (.doc),and "SPLIT_DISTRICTS_04_03_2017_08_57_17" (.zip)

The three (3) metadata files are not used directly in the analysis, and therefore do not require additional formatting and can be viewed as is

"README FILE_EX-003" ought to be opened in Microsoft Word and read first since it functions as an introudction to the voter registration data sets as well as the other two metadata files (e.g. explains naming conventions)

"Public EX-003-File Layout" (.xlsx) ought to be viewed second since it contains metadata that defines and explains each attribute column (offers additional notes and char.length for each attribute)

"SPLIT_DISTRICTS_04_03_2017_08_57_17" comprises 2,400,26 records describing "split" voting districts and precints along with "split_code," "precint_code," "district_type," "district_name," and "county" and probably can be discarded

## INSTRUCTIONS FOR FILE PREPARATION

In Excel, using the Text Import Wizard, open the eight files titled "Registered_Voters_List_Part1.txt" through "..._Part8.txt"

On Step 1/3 in Text Import Wizard, choose option "Delimited - Characters such as commas or tabs separate each field, DO NOT choose  "Fixed width - ...," then click "Next"

On step 2/3 in Text Import Wizard, beneath heading "Delimiters," select boxes "Tab" and "Comma," DO NOT select boxes "Semicolon," "Space," or "Other," then click "Next"

On step 3/3 in Text Import Wizard, DO NOT select or modify any options; simply click "Finish" and the files will open in Excel in a .txt format

Once a .txt file opens in Excel, immediately save it in "Workspace" folder as a .csv formatted file. Close the Excel .txt file and proceed to R. Script to read in file

NOTE: It may take Excel up to 30 seconds to open each .txt / .csv file since each contains 500,000 observations & 55 attributes (except Part8, which contains 1.6k records)

## USEFUL URLs & RESOURCES

https://www.r-bloggers.com/voter-targeting-with-r/ || Describes three (3) steps to voter targeting for turnout
https://github.com/tidyverse/dplyr || Tutorial on 'dplyr' and related "tidyverse"
https://www.r-statistics.com/tag/election-prediction/
https://data.colorado.gov/browse?category=Nonprofit+Data&utf8=✓
https://www.r-bloggers.com/exploring-your-voter-file-with-r/
http://ellisp.github.io/blog/2016/04/04/nzelect2/
