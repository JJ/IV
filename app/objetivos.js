#!/usr/bin/env node

var date=process.argv[2];

var URL="https://github.com/IV-GII/GII-2013/wiki/Clasedel"+date;

var request=require('request');
var cheerio=require('cheerio');

request(URL, function (error, response, body) {
  if (!error && response.statusCode == 200) {
      $ = cheerio.load(body);
      var objetivos = $('ol li');
//      console.log(objetivos);
      objetivos.each( function(i, elem) {
//	  console.log(elem);
	  console.log( "[ ] "+ $(this).text() );
      });
      
  }
});