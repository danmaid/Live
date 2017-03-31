var width = q.width = q.clientWidth;
var height = q.height = q.clientHeight;
var drawing = new Array();

// URL追加ボタン
// var urlButton = document.getElementById('add');
// var addURLStream = Rx.Observable.fromEvent(urlButton, 'click');
// addURLStream.subscribe(function (e) {
//     console.log(e);
// });

// サーバから取得するストリーム
var responseStream1 = Rx.DOM.fromEventSource('http://localhost:6901/sse');
responseStream1.subscribe(function (response) {
    console.debug(response);
    let data = {
        'y_pos': 0,
        'x_pos': Math.floor(Math.random() * ((width / 10) + 1)) * 10,
        'char_pos': 0,
        'text': response,
        'color': '#FFF'
    };
    drawing.push(data);
});

var responseStream2 = Rx.DOM.fromEventSource('http://localhost:6902/sse');
responseStream2.subscribe(function (response) {
    console.debug(response);
    let data = {
        'y_pos': 0,
        'x_pos': Math.floor(Math.random() * ((width / 10) + 1)) * 10,
        'char_pos': 0,
        'text': response,
        'color': '#0F0'
    };
    drawing.push(data);
});

// 描画する
var draw = function () {
    q.getContext('2d').fillStyle = 'rgba(0,0,0,.1)';
    q.getContext('2d').fillRect(0, 0, width, height);
    drawing.map(function (data, index) {
        char_pos = data.char_pos < data.text.length ? data.char_pos : 0;
        char = data.text.charAt(char_pos);
        data.char_pos = char_pos + 1;
        q.getContext('2d').fillText(char, data.x_pos, data.y_pos);
        q.getContext('2d').fillStyle = data.color;
        (data.y_pos > 758 + Math.random() * 1e4) ? drawing.splice(index, 1) : data.y_pos += 10;
    });
};
setInterval(draw, 100);
