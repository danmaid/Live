<engineer>
    <style scoped>
        console1 {
            width: auto;
            min-width: 40em;
            max-width: 100%;
            max-height: 20em;
            transition: all 1s;
            white-space: nowrap;
            position: unset;
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

        .group .title,
        .group .subtitle {
            color: #fff;
            font-size: 12px;
        }

        .group .item {
            width: 20%;
            padding: 0.2em;
        }
    </style>
    <console1 id="console1"></console1>
    <div id="group1" class="group">
        <!-- <div class="item"> -->
        <!-- <div class="title">key</div> -->
        <!-- <div class="subtitle">timestamp</div> -->
        <!-- <list1></list1> -->
        <!-- </div> -->
    </div>

    <script>
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

        Promise.all([compileConsole1, compileList1])
            .then(function () {
                console1 = riot.mount('#console1')[0];
                console.debug('step mount');
            })
            .then(function () {
                demo6901source
                    .map(function (x) {
                        let line = document.createElement('div');
                        line.innerText = JSON.stringify(x);
                        return line;
                    })
                    .subscribe(function (x) { console1.add(x); });

                // name で分割した支流を作る
                let demo6901byName = demo6901source
                    .groupBy(function (x) { return x.name })
                    .do(function (x) {
                        console.debug(x);
                    })
                    .share();

                demo6901byName.subscribe(function (stream) {
                    // 支流ごとに DOM を作る
                    let parent = document.getElementById('group1');
                    let group = document.createElement('div');
                    let title = document.createElement('div');
                    let timestamp = document.createElement('div');
                    let list = document.createElement('list1');
                    let tag;
                    parent.appendChild(group);
                    group.classList.add('item');
                    group.appendChild(title);
                    group.appendChild(timestamp);
                    timestamp.classList.add('subtitle');
                    group.appendChild(list);
                    title.innerText = stream.key;
                    title.classList.add('title');
                    tag = riot.mount(list)[0];

                    // 支流の処理を作る
                    stream.subscribe(function (x) {
                        timestamp.innerText = x.timestamp.toLocaleString();
                        Rx.Observable.from(Object.keys(x.fields)).subscribe(function (key) {
                            let div = document.createElement('div');
                            div.innerText = key + ':' + x.fields[key];
                            tag.add(key, div);
                        });
                    });
                });
            });
    </script>

</engineer>