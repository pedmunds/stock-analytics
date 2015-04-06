/* Code to get short information */

/*get list of share isins from file*/
var shortArray = [];

fs = require('fs')
fs.readFile('ISINfile.txt', 'utf8', function (err,data) {
  if (err) {
    return console.log(err);
  }
  shortArray = data.split(',');
  shortArray.forEach(logArrayElements);
});

function logArrayElements(element, index, array) {
  console.log('a[' + index + '] = ' + element);
shortDataGrabber('http://shorttracker.co.uk/company/'+element+'/all');
}

function shortDataGrabbertest(url)
{
			var share=url.toString();			
			share=share.substring(share.indexOf("company/")+8
,share.lastIndexOf("/all"));
		console.log(share);
}

function shortDataGrabber(url)
{
/* function to grab short data and write to a file for data import */

var sjs = require('../../src/Scraper')

/*
 Get all the links in a page.
 */
sjs.StaticScraper
	.create()
	.onStatusCode(function(code) {
		console.log(code);
	})
	.scrape(function($) {
		return $('script').map(function() {
			return $(this).html();
		}).get();
	}, function(links) {
			links.forEach(function(link) {
			/*console.log(url);
			var share=url.toString();			
			share=share.substring(share.indexOf("/j")+1
,share.lastIndexOf("/placement"));
			console.log(share);
*/

			if (link.indexOf("drawChart") > -1)
			{
			var share=url.toString();			
			share=share.substring(share.indexOf("company/")+8
,share.lastIndexOf("/all"));
			/*console.log(share);*/


			var string=link.substring(link.lastIndexOf("addRows([")+1,link.lastIndexOf("]);"));
			/*fix data issues*/
			string = string.replace(/,0,/g, ",-01-,");
			string = string.replace(/,1,/g, ",-02-,");
			string = string.replace(/,2,/g, ",-03-,");
			string = string.replace(/,3,/g, ",-04-,");
			string = string.replace(/,4,/g, ",-05-,");
			string = string.replace(/,5,/g, ",-06-,");
			string = string.replace(/,6,/g, ",-07-,");
			string = string.replace(/,7,/g, ",-08-,");
			string = string.replace(/,8,/g, ",-09-,");
			string = string.replace(/,9,/g, ",-10-,");
			string = string.replace(/,10,/g, ",-11-,");
			string = string.replace(/,11,/g, ",-12-,");
			/*put into list*/
			string = string.replace(/,/g, "");
			string = string.replace(/ddRows\(\[/g, "");
			string = string.replace(/\]\);/g, "");
			string = string.replace(/\[new Date\(/g, share + ",");
			string = string.replace(/\) /g, ",");
			string = string.replace(/\]/g, "");
			string = string.replace(/ null/g, "");
			/*console.log(string);*/

var fs = require('fs');
			fs.appendFile('shorts.txt', string, function (err) {

});
			}

		});
	})
	.get(url);


};
