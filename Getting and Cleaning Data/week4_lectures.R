# regex
^ begin of line
$ end of line
# [Bb] matches lower/upper 'b'
^[Ii] am will match I/i in first position
# [a-zA-Z] any letter
# [^?.]$ means match any character ending other than ? . - here ^ means not
# . refers to any one character 9.11 matches 9:11, 9-11, 9/11
# | or - flood|fire looks for either
# ^([Gg]ood]|[[Bb]ad]) - looks for Good or Bad at begin of line
# \. escape certain characters
# (.*) will match lines with parantheses and possibly something in between
# [0-9]+ means must have at least one of the specified characters
# (.*)[0-9]+
# {} interval qualifiers
# {1,5} min is 1, max is 5
# m,n at least m but not more than n
# +([a-zA-Z]+) +\1 +   matches words that repeat - the \1 means the first match from the regex
# * always matches the longest possible string that matches
# grep - search
# grepl
# sub (1st replacement), gsub (replace all)



#DATES
# lubridate package
# ymd, dmy,mdy, 
# times
# ymd_hms
# ?Sys.timezone
# wday
# POSIXlt / POSIXct


#DATA
data.gov/opendatasites
# gapminder
# asdfree - survey data
# infochimps, kaggle, 