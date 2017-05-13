<debugger-dual>
    <style scoped>
        .dual {
            display: flex;
        }

        .dual article {
            max-width: 50%;
        }

        console1 {
            width: auto;
            min-width: 40em;
            max-width: 100%;
            max-height: 20em;
            transition: all 1s;
            white-space: nowrap;
            position: unset;
            display: block;
        }

        .title {
            color: #fff;
            font-size: 12px;
        }
    </style>
    <div class="dual">
        <article>
            <span class="title">demo6901source</span>
            <console1 id="console1"></console1>
        </article>
        <article>
            <span class="title">demo6902source</span>
            <console1 id="console2"></console1>
        </article>
    </div>

    <script>
        let self = this;
        const compileConsole1 = new Promise(function (resolve, reject) {
            riot.compile('tags/console1.tag', function () {
                console.debug('compiled console1');
                resolve();
            });
        });

        Promise.all([compileConsole1])
            .then(function () {
                console1 = riot.mount('#console1')[0];
                console2 = riot.mount('#console2')[0];
                console.debug('step mount');
            })
            .then(function () {
                // 本流をコンソールに流す
                subscription = demo6901source
                    .map(function (x) {
                        let line = document.createElement('div');
                        line.innerText = JSON.stringify(x);
                        return line;
                    })
                    .subscribe(function (x) { console1.add(x); });
                self.on('unmount', function () {
                    console.debug('dispose:', this);
                    this.dispose();
                }.bind(subscription));

                subscription = demo6902source
                    .map(function (x) {
                        let line = document.createElement('div');
                        line.innerText = x;
                        return line;
                    })
                    .subscribe(function (x) { console2.add(x); });
                self.on('unmount', function () {
                    console.debug('dispose:', this);
                    this.dispose();
                }.bind(subscription));

            });
    </script>

</debugger-dual>