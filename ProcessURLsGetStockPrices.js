/* Code to get share information */

/*get list of share isins from file
get stock data from a url like this:
http://www.google.co.uk/finance/historical?q=LON:888&startdate=31-Oct-12&enddate=&output=csv
output parsed details to shares.txt file for database import
*/

// enter stat and end dates for historic data
var startdate= '31-Oct-12'
var enddate='' //blank = today
var shareArray = [];


fs = require('fs')
fs.appendFile('shares.txt', 'EPIC,DATE,CLOSE\n', function (err) {});
fs.readFile('epicsfile.txt', 'utf8', function (err,data) {
  if (err) {
    return console.log(err);
  }
  shareArray = data.split(',');
  shareArray.forEach(logArrayElements);
});

function logArrayElements(element, index, array) {
  console.log('a[' + index + '] = ' + element);
shareDataGrabber('http://www.google.co.uk/finance/historical?q=LON:'+element+'&startdate='+startdate+'&enddate='+enddate+'&output=csv', element);
}

function shareDataGrabbertest(url, epic)
{
			var share=url.toString();			
			console.log(share);
}

function shareDataGrabber(url, epic)
{
/* function to grab share data and write to a file for data import */

/*
 Get all the data.
 */
var request = require("request");

request(url, function (error, response, body) {
    if (!error) {
        parsecsv(body);
    } else {
        console.log("no csv " + error);
    }
});

var parsecsv = function(allText) {

	if (allText.indexOf("Close,") > -1)
	{
	var fs = require('fs');
    //console.log(allText);
    var allTextLines = allText.split(/\r\n|\n/);
	var line = '';

    for (var i=1; i<allTextLines.length-1; i++) {
        var data = allTextLines[i].split(',');
		// get date plus close
		line = line + epic + ',' + data[0] + ',' + data[4] + '\n';
    }
//console.log(line);
fs.appendFile('shares.txt', line, function (err) {console.log(err);});


    }

};

}

