// Initialize dependencies
var express = require('express');
var bodyParser = require('body-parser');
var http = require("http");
var request = require('request');
var util = require('util');
var lodash = require('lodash');
var bbPromise = require('bluebird');

var app  = express();
var portNumber = process.env.PORT || 9000;
app.set("port", portNumber);
app.use(express.static('screenshots'));
app.use(express.static('assets'));

	// Routes mapping
	app.get('/', function (req, res) {  
	  res.sendFile(__dirname + '/index.html');
	});

	app.get('/search', function (req, res, next) {  
		var term = req.query.term;
		console.log('Search Request For Term: '+term);		
		FetchData(term).then(function(result) {
			res.json(result);
		});  
	});

	// Bluebird promise responsible for fetching graph search results from elasticsearch database
	function FetchData(term) {
		
		var requestData = {
				"title-suggest" : {
					"prefix" : term,
					"completion" : {
						"field" : "title"
					}
				}
		}
			
		return new bbPromise(function(resolve, reject) {			
			request('http://10.0.2.2:9200/books/_suggest?pretty=true',{ json: true, body: requestData },function(error, res, body) {
				if(error){reject(error)};
				console.log(util.inspect(body, {showHidden: false, depth: null}));
				var data = body['title-suggest'][0].options;				
				var results = lodash.map(data, '_source');
				resolve(results)			
			});			
		})
	}

	// Start Nodejs Server
	var server = http.createServer(app).listen(app.get('port'), function(req, res){
		console.log("Server is listening on port " + app.get('port'));	
	});
