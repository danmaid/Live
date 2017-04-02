// watch のように毎回クリア
function watch(stream, targetDom) {
    stream.subscribe(function (response) {
        targetDom.textContent = null;
        let line = document.createElement('div');
        line.innerText = response;
        targetDom.appendChild(line);
    });
}
