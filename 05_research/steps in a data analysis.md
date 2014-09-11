###Steps in a data analysis Steps in a data analysis
####(from week 1's lectures)

Define the question
* Start with a general question (eg, *"Can I automatically detect emails that are SPAM that are not?"*)
* Then make it concrete (eg, *"Can I use quantitative characteristics of the emails to classify them as SPAM/HAM?"*) 

Define the ideal data set
* The data set may depend on your goal
* Descriptive - a whole population
* Exploratory - a random sample with many variables measured
* Inferential - the right population, randomly sampled
* Predictive - a training and test data set from the same population
* Causal - data from a randomized study
* Mechanistic - data about all components of the system

Determine what data you can access
* Sometimes you can find data free on the web
* Other times you may need to buy the data
* Be sure to respect the terms of use
* If the data don't exist, you may need to generate it yourself

Obtain the data
* Try to obtain the raw data
* Be sure to reference the source
* Polite emails go a long way
* If you will load the data from an internet source, record the url and time accessed

Clean the data
* Raw data often needs to be processed
* If it is pre-processed, make sure you understand how
* Understand the source of the data (census, sample, convenience sample, etc.)
* May need reformating, subsampling - record these steps
* Determine if the data are good enough - if not, quit or change data

Exploratory data analysis
* Look at summaries of the data
* Check for missing data
* Create exploratory plots
* Perform exploratory analyses (e.g. clustering) 

Statistical prediction/modeling
* Should be informed by the results of your exploratory analysis
* Exact methods depend on the question of interest
* Transformations/processing should be accounted for when necessary
* Measures of uncertainty should be reported

Interpret results
* Use the appropriate language (describes, correlates with/associated with, leads to/causes, predicts)
* Give an explanation
* Interpret coefficients
* Interpret measures of uncertainty

**Challenge results**

Synthesize/write up results
* Lead with the question
* Summarize the analyses into the story
* Don't include every analysis, include it if it is needed for the story or to address the challenge
* Order analyses according to the story, rather than chronologically
* Include "pretty" figures that contribute to the story

Create reproducible code