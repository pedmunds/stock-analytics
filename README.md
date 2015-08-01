# stock-analytics
Tool to scrape large volumes of UK share data and put into database, then process it for statistic analysis

# Share price and short analytics for UK
Runs under node js
[![Dependency Status] (https://travis-ci.org/ruipgil/scraperjs.svg)]

A simple system that gets UK share price information from the web, processes the data in a database to draw statistical correlations and then outputs the data, for further analysis.

This code contains:
+ scrapers to get price information for shares and short information on shorts
+ database for import of data in SQL express
+ processing script for putting the data in a single view
+ processing script for calculating relationships between share price and short interest
+ export script for processed data

# Installing

You need to install scraperjs (npm install scraperjs)
download this from https://github.com/ruipgil/scraperjs
Copy the process*.js scripts to the scraperjs folder under nodejs modules
Install MS SQL Express (free) and restore the database

# Getting started

1) Get the latest data from the web on shares and shorts by running the process*.js files: 
- ProcessURLsGetShortValues.js - looks for a list of shares in ISINfile.txt outputs historic values to shorts.txt
- ProcessURLsGetStockPrices.js - looks for a list of shares in epicsfile.txt outputs historic values to shares.txt

2) Import the data (shorts.txt and shares.txt) into the database using dtswizard.exe to import the data into tables dbo.short and dbo.shares (import.js to follow).

3) Run the procedures to process the raw data:
  - process shortsReal.sql : adds the short data to the shares data
  - process shortsCorrelations.sql : adds statistical correlations to the shares data
  - ReturnFinalData.sql : selects the processed shares data and returns a table that you paste into spreadsheets for analysis

# Usage

This is a prototype application that scrapes data, processes it and returns a results set that can be used for share price analysis. Interesting correlations in the data show a relationship between shorts and share price drops for certain classes of shares.


# Dependencies

As mentioned above, this is an implementation of scraperjs 
+ https://travis-ci.org/ruipgil/scraperjs.svg

# License

This project is under the [MIT](./LICENCE) license. 

