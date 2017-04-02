// Matrix code のように。
function matrixCode(stream, targetDom) {
    var canvas = document.createElement('canvas');
    targetDom.appendChild(canvas);
    var width = canvas.width = targetDom.clientWidth;
    var height = canvas.height = targetDom.clientHeight;
    var drawing = new Array();

    var draw = function () {
        canvas.getContext('2d').fillStyle = 'rgba(0,0,0,.1)';
        canvas.getContext('2d').fillRect(0, 0, width, height);
        drawing.map(function (data, index) {
            char_pos = data.char_pos < data.text.length ? data.char_pos : 0;
            char = data.text.charAt(char_pos);
            data.char_pos = char_pos + 1;
            canvas.getContext('2d').fillText(char, data.x_pos, data.y_pos);
            canvas.getContext('2d').fillStyle = data.color;
            (data.y_pos > (height + data.text.length * 10)) ? drawing.splice(index, 1) : data.y_pos += 10;
        });
    };
    setInterval(draw, 100);

    stream.subscribe(function (response) {
        let line = document.createElement("div");
        let data = {
            'y_pos': 0,
            'x_pos': Math.floor(Math.random() * ((width / 10) + 1)) * 10,
            'char_pos': 0,
            'text': response,
            'color': '#0F0'
        };
        drawing.push(data);
    });
}
