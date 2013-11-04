#!/usr/bin/env node

/* Script para bajarse los objetivos del día.

Instalación: 

sudo apt-get install node
sudo cp objetivos.js /usr/local/bin
cd /usr/local/bin
npm install request
npm install cheerio
chmod +x objetivos.js

Uso:
objetivos.js 21102013 (para la clase que tenga esa fecha original)

*/

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