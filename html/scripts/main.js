/**
 * リンク追加処理
 */
var addLink = (function () {
    // 追加対象レイヤー
    var targetLayer;
    // 範囲選択用キャンバス
    var canvas;
    var canvasContext;

    // 選択範囲格納用オブジェクト
    var rectangle = {
        startX: 0,
        startY: 0,
        width: 0,
        height: 0,
        clear: function () {
            this.startX = 0;
            this.startY = 0;
            this.width = 0;
            this.height = 0;
        }
    };

    // 初期化
    var addLink = function (_canvas, _target) {
        canvas = _canvas;
        targetLayer = _target;
        canvasContext = canvas.getContext("2d");

        // キャンバスサイズを 100% に設定
        // TODO: リサイズ対応
        canvas.width = canvas.clientWidth;
        canvas.height = canvas.clientHeight;

        canvas.addEventListener("mousedown", onMouseDown);
        canvas.addEventListener("mouseup", onMouseUp);

        canvas.style.display = "block";
        canvas.style.cursor = "crosshair";
    };


    function cleanup() {
        canvas.removeEventListener("mousemove", onMouseMove);
        canvas.removeEventListener("mousedown", onMouseDown);
        canvas.removeEventListener("mouseup", onMouseUp);
        canvas.style.display = "none";
    }


    function onMouseDown(e) {
        // 矩形始点
        console.log("mousedown: " + e.offsetX + "," + e.offsetY);
        rectangle.startX = e.offsetX;
        rectangle.startY = e.offsetY;
        canvas.addEventListener("mousemove", onMouseMove);
    };

    function onMouseMove(e) {
        // 範囲決め
        canvasContext.clearRect(0, 0, canvas.width, canvas.height);
        canvasContext.strokeRect(rectangle.startX, rectangle.startY, (e.offsetX - rectangle.startX), (e.offsetY - rectangle.startY));
    };

    function onMouseUp(e) {
        // 矩形終点
        console.log("mouseup: " + e.offsetX + "," + e.offsetY);
        rectangle.width = e.offsetX - rectangle.startX;
        rectangle.height = e.offsetY - rectangle.startY;

        // 要素の追加
        var a = document.createElement("a");
        a.classList.add("link");
        a.style.width = rectangle.width + "px";
        a.style.height = rectangle.height + "px";
        a.style.position = "absolute";
        a.style.left = rectangle.startX + "px";
        a.style.top = rectangle.startY + "px";
        a.style.pointerEvents = "auto";
        a.href = "#";
        target.appendChild(a);

        cleanup();
    };

    function openURL(e) {
        console.log(e);
    };

    return addLink;
})();

