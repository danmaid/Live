<operator>
    <gauge3 data-max="100" data-min="0" data-value="30" style="width: 10em;">Memory</gauge3>

    <button id="test">Update</button>

    <script>
        let self = this;

        const compileGauge3 = new Promise(function (resolve, reject) {
            riot.compile('tags/gauge3.tag', function () {
                console.debug('compiled gauge3');
                resolve();
            });
        });

        Promise.all([compileGauge3])
            .then(function () {
                let gauge = riot.mount('gauge3')[0];
                document.getElementById('test').addEventListener('click', function (e) {
                    gauge.root.dataset.value = 50;
                    gauge.update();
                });
            });
    </script>
</operator>