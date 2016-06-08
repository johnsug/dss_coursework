# course notes from Johns Hopkins University/Coursera's "Getting and Cleaning Data" class

## reading local files
```{r}
read.csv(filename)  
## optional parameters: nrows = number of rows to read in; skip = number of line to skip before reading
```

## reading excel files
```{r}
library(xlsx)
read.xlsx(filename, sheetIndex=1, colIndex=..., rowIndex=... )
read.xlsx2()  ## faster than above, but may be unstable when reading subsets
```

## reading XML
note: extracting XML is the basis for most web scrapping
```{r}
library(XML)

# read data
doc <- xmlTreeParse("http://www.w3schools.com/xml/simple.xml",useInternal=TRUE)

rootNode <- xmlRoot(doc)      # save node
xmlName(rootNode)             # list node name
rootNode[[1]]                 # read first line of node
rootNode[[1]][[1]]            # read first element of node
xmlSApply(rootNode,xmlValue)  # extracting elements of the file

xpathSApply(rootNode,"//name",xmlValue)   ## get items on the menu
xpathSApply(rootNode,"//price",xmlValue)  ## get item prices
```

## reading JSON
JSON = JavaScript Object Notation

```{r}
library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData) 
names(jsonData$owner)

# writing data frames to JSON
myjson <- toJSON(iris, pretty=TRUE)
cat(myjson)

# converting back to df 
iris2 <- fromJSON(myjson)
head(iris2)
```

## reading from the web

* Many websites have information you may want to programaticaly read
* In some cases this is against the terms of service for the website
* Attempting to read too many pages too quickly can get your IP address blocked

```{r}
con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)
htmlCode
```

## reading from APIs

```{r}
# Twitter from R
myapp = oauth_app("twitter", key="yourConsumerKeyHere",secret="yourConsumerSecretHere")
sig = sign_oauth1.0(myapp,
                    token = "yourTokenHere",
                    token_secret = "yourTokenSecretHere")
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)
## see https://dev.twitter.com/docs/api/1.1/get/search/tweets to know which URL to use

# converting the JSON object
json1 = content(homeTL)
json2 = jsonlite::fromJSON(toJSON(json1))
json2[1,1:4]
```

## reading from other sources
```{r}
library(foreign)
read.arff(...)    ## Weka
read.dta(...)     ## Stata
read.mtp(...)     ## Minitab
read.octive(...)  ## Octave
read.spss(...)    ## SPSS
read.xport(...)   ## SAS
```

* other custom packages include: `twitteR`, `RFacebook`, `RGoogleMaps`, `ROpenSci`
* for reading GIS data, look into the following packages: `rdgal`, `rgeos`, `raster`
