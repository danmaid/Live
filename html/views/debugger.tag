<debugger>
    <style scoped>
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

        .group {
            display: flex;
            flex-wrap: wrap;
            width: 100%;
            position: absolute;
        }

        .group list1 {
            position: unset;
        }

        .title,
        .subtitle {
            color: #fff;
            font-size: 12px;
        }

        .group .item {
            width: 20%;
            padding: 0.2em;
            position: relative;
        }

        .group barbar {
            position: absolute;
            left: 50%;
            top: 50%;
            transform: rotate(90deg);
            width: 100px;
        }

        .groupby {
            filter: invert(100%);
            height: 4em;
            margin: 0 auto;
        }
    </style>
    <span class="title">demo6901source</span>
    <console1 id="console1"></console1>
    <img class="groupby" src="views/groupby.jpg" />
    <div id="group1" class="group">
        <!-- <div class="item"> -->
        <!-- <div class="title">key</div> -->
        <!-- <div class="subtitle">timestamp</div> -->
        <!-- <list1></list1> -->
        <!-- <barbar></barbar> -->
        <!-- </div> -->
    </div>

    <script>
        let self = this;

        const compileConsole1 = new Promise(function (resolve, reject) {
            riot.compile('tags/console1.tag', function () {
                console.debug('compiled console1');
                resolve();
            });
        });

        const compileList1 = new Promise(function (resolve, reject) {
            riot.compile('tags/list1.tag', function () {
                console.debug('compiled list1');
                resolve();
            });
        });

        const compileBarbar = new Promise(function (resolve, reject) {
            riot.compile('tags/barbar.tag', function () {
                console.debug('compiled barbar');
                resolve();
            });
        });

        Promise.all([compileConsole1, compileList1, compileBarbar])
            .then(function () {
                console1 = riot.mount('#console1')[0];
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

                // name で分割した支流を作る
                let demo6901byName = demo6901source
                    .groupBy(function (x) { return x.name })
                    .do(function (x) {
                        console.debug(x);
                    })
                    .share();

                subscription = demo6901byName.subscribe(function (stream) {
                    // 支流ごとに DOM を作る
                    let parent = document.getElementById('group1');
                    let group = document.createElement('div');
                    let title = document.createElement('div');
                    let timestamp = document.createElement('div');
                    let list = document.createElement('list1');
                    let bar = document.createElement('barbar');
                    let tag;
                    parent.appendChild(group);
                    group.appendChild(title);
                    group.appendChild(timestamp);
                    group.appendChild(list);
                    group.appendChild(bar);
                    group.classList.add('item');
                    timestamp.classList.add('subtitle');
                    title.innerText = stream.key;
                    title.classList.add('title');
                    tag = riot.mount(list)[0];
                    bar = riot.mount(bar)[0];


                    // 支流の処理を作る
                    subscription = stream.subscribe(function (x) {
                        timestamp.innerText = x.timestamp.toLocaleString();
                        Rx.Observable.from(Object.keys(x.fields)).subscribe(function (key) {
                            let div = document.createElement('div');
                            div.innerText = key + ':' + x.fields[key];
                            tag.add(key, div);
                        });
                    });
                    self.on('unmount', function () {
                        console.debug('dispose:', this);
                        this.dispose();
                    }.bind(subscription));

                    // 支流でバーを回す。データが来る間は回して、1秒来なければ停止。
                    subscription = stream
                        .do(function (x) {
                            bar.update({ value: 1 });
                        })
                        .debounce(1000)
                        .subscribe(function (x) {
                            bar.update({ value: 0 });
                        });
                    self.on('unmount', function () {
                        console.debug('dispose:', this);
                        this.dispose();
                    }.bind(subscription));
                });
                self.on('unmount', function () {
                    console.debug('dispose:', this);
                    this.dispose();
                }.bind(subscription));
            });
    </script>

</debugger>