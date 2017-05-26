var express = require('express');
var http = require('http');
var app = express();
var EventEmitter = require('events').EventEmitter;
var ev = new EventEmitter();
var readline = require('readline');
var argv = require('argv');

// オプション
argv.option({
  name: 'port',
  short: 'p',
  type: 'string'
});

var port = argv.run().options.port;
console.log(port);

// 入力側
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});
reader.on('line', function (line) {
  console.log(line);
});
reader.on('close', function () {
  console.log("--- input closed. ---");
});

app.use(express.static(__dirname + '/public'));

app.get('/sse', function (req, res) {
  res.setHeader('Content-Type', 'text/event-stream');
  res.setHeader('Cache-Control', 'no-cache');
  res.setHeader('Connection', 'no-cache');
  res.setHeader('Connection', 'keep-alive');
  res.setHeader('Access-Control-Allow-Origin', '*');

  console.log('client connected.', req.ip);

  // 55秒のタイムアウト対策
  var timer = setInterval(function () {
    res.write(':\n\n');
  }, 50000);

  // 最初の30秒のタイムアウト対策
  res.write(':\n\n');

  ev.on('data', function (data) {
    console.log(data);
    res.write('data: ' + data + '\n\n');
  });

  req.on('close', function () {
    clearTimeout(timer);
    console.log('client closed.', req.ip);
  });
});

reader.on('line', function (line) {
  ev.emit('data', line);
});

if (port == null) {
  port = 6969;
}
http.createServer(app).listen(port, function () {
  console.log('Express server listening on ', port);
});
