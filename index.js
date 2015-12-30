var express = require('express');
var path = require('path');
var morgan = require('morgan');
var connectAssets = require('connect-assets');
var app = express();

app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

app.use(connectAssets({
  paths: [
    'assets/js',
    'assets/css'
  ]
}));

app.use(morgan('combined'));

app.get('/', function(req, res){
  var engine = req.query.engine || 'svg';
  res.render('index', { engine: engine });
});

app.use('/static', express.static(path.join(__dirname, 'public')));
app.use('/vendor', express.static(path.join(__dirname, 'bower_components')));

var server = app.listen(3030, function(){
  var host = server.address().address;
  var port = server.address().port;
  console.log("Listening at http://%s:%s", host, port);
});
