// tail -f のようにだらだらと。
function tailf(stream, targetDom) {
    stream.subscribe(function (response) {
        let line = document.createElement('div');
        line.innerText = response;
        targetDom.appendChild(line);
        targetDom.scrollTop = targetDom.scrollHeight;
    });
}
