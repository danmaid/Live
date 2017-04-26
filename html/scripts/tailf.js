// tail -f のようにだらだらと。
function tailf(stream, targetDom) {
    stream.subscribe(function (response) {
        let line = document.createElement('div');
        line.innerText = response;
        targetDom.appendChild(line);
        targetDom.scrollTop = targetDom.scrollHeight;
    });
}

// tail -f だけど、バッファサイズ = 描画面サイズ
function tailfLimit(stream, targetDom) {
    var bufferSize = targetDom.clientHeight;
    var childHeight = 0;
    stream.subscribe(function (response) {
        let line = document.createElement('div');
        line.innerText = response;
        targetDom.appendChild(line);
        childHeight += line.clientHeight;
        if (childHeight > bufferSize) {
            childHeight -= line.clientHeight;
            targetDom.removeChild(targetDom.firstChild);
        }
    });
}