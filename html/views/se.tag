<se>
    <img class="bg" src="views/demo.png" />

    <div class="layer status">
        <status2 id="demo" style="left:170px; top:100px;"></status2>

        <status2 id="telegraf" style="left:100px; top:180px;"></status2>
        <status2 id="rsyslogd" style="left:100px; top:250px;"></status2>
        <status2 id="nginx" style="left:100px; top:310px;"></status2>
        <status2 id="tcpdump" style="left:105px; top:510px;"></status2>
    </div>

    <div class="layer console">
        <console1 id="telegraf" style="left:270px; top:180px;"></console1>
        <console1 id="rsyslogd" style="left:270px; top:250px;"></console1>
        <console1 id="errorlog" style="left:270px; top:370px;"></console1>
        <console1 id="accesslog" style="left:270px; top:425px;"></console1>
        <console1 id="tcpdump" style="left:270px; top:500px;"></console1>
    </div>

    <style>
         :scope {
            position: relative;
        }

        .bg {
            position: absolute;
            top: 0;
            left: 0;
            height: 700px;
            filter: invert(100%);
        }

        status2 {
            width: 40px;
            height: 40px;
        }

        console1 {
            width: 10em;
            height: 3em;
            transition: all 1s;
        }

        console1:hover {
            font-size: 16px;
            width: 30em;
            height: 20em;
            z-index: 999;
            overflow: scroll;
        }
    </style>

    <script>
        self = this;

        let compileStatus2 = new Promise(function (resolve, reject) {
            riot.compile('tags/status2.tag', function () {
                resolve();
            });
        });
        let compileConsole1 = new Promise(function (resolve, reject) {
            riot.compile('tags/console1.tag', function () {
                resolve();
            });
        });

        Promise.all([compileStatus2, compileConsole1])
            .then(function () {
                statusDemo       = riot.mount('status2#demo')[0];
                statusTelegraf   = riot.mount('status2#telegraf')[0];
                statusRsyslogd   = riot.mount('status2#rsyslogd')[0];
                statusNginx      = riot.mount('status2#nginx')[0];
                statusTcpdump    = riot.mount('status2#tcpdump')[0];
                consoleTelegraf  = riot.mount('console1#telegraf')[0];
                consoleRsyslogd  = riot.mount('console1#rsyslogd')[0];
                consoleErrorlog  = riot.mount('console1#errorlog')[0];
                consoleAccesslog = riot.mount('console1#accesslog')[0];
                consoleTcpdump   = riot.mount('console1#tcpdump')[0];
                console.log('mounted');
            })
            .then(function () {
                // demo available
                subscription = Rx.Observable.merge([demo6901source, demo6902source, demoErrorlogSource, demoAccesslogSource, demoTcpdumpSource])
                    .do(function (x) { console.debug('all:', x); })
                    .do(function (x) {
                        statusDemo.play();
                    })
                    .debounce(2000)
                    .subscribe(function (x) {
                        statusDemo.pause();
                    });
                self.on('unmount', function () { this.dispose(); }.bind(subscription));


                // telegraf console
                subscription = demo6901source
                    .do(function (x) { console.debug('telegraf:', x); })
                    .map(function (x) {
                        let line = document.createElement('div');
                        line.innerText = JSON.stringify(x);
                        return line;
                    })
                    .subscribe(function (x) {
                        consoleTelegraf.add(x);
                        self.update();
                    });
                self.on('unmount', function () { this.dispose(); }.bind(subscription));
                // telegraf available
                subscription = demo6901source
                    .do(function (x) { console.debug('telegraf:', x); })
                    .do(function (x) {
                        statusTelegraf.play();
                    })
                    .debounce(2000)
                    .subscribe(function (x) {
                        statusTelegraf.pause();
                    });
                self.on('unmount', function () { this.dispose(); }.bind(subscription));

                // rsyslogd console
                subscription = demo6902source
                    .do(function (x) { console.debug('rsyslogd:', x); })
                    .map(function (x) {
                        let line = document.createElement('div');
                        line.innerText = JSON.stringify(x);
                        return line;
                    })
                    .subscribe(function (x) {
                        consoleRsyslogd.add(x);
                        self.update();
                    });
                self.on('unmount', function () { this.dispose(); }.bind(subscription));
                // rsyslogd available
                subscription = demo6902source
                    .do(function (x) { console.debug('rsyslogd:', x); })
                    .do(function (x) {
                        statusRsyslogd.play();
                    })
                    .debounce(2000)
                    .subscribe(function (x) {
                        statusRsyslogd.pause();
                    });
                self.on('unmount', function () { this.dispose(); }.bind(subscription));

                // errorlog console
                subscription = demoErrorlogSource
                    .do(function (x) { console.debug('errorlog:', x); })
                    .map(function (x) {
                        let line = document.createElement('div');
                        line.innerText = JSON.stringify(x);
                        return line;
                    })
                    .subscribe(function (x) {
                        consoleErrorlog.add(x);
                        self.update();
                    });
                self.on('unmount', function () { this.dispose(); }.bind(subscription));

                // accesslog console
                subscription = demoAccesslogSource
                    .do(function (x) { console.debug('accesslog:', x); })
                    .map(function (x) {
                        let line = document.createElement('div');
                        line.innerText = JSON.stringify(x);
                        return line;
                    })
                    .subscribe(function (x) {
                        consoleAccesslog.add(x);
                        self.update();
                    });
                self.on('unmount', function () { this.dispose(); }.bind(subscription));
                // nginx available
                subscription = Rx.Observable.merge([demoErrorlogSource, demoAccesslogSource])
                    .do(function (x) { console.debug('nginx:', x); })
                    .do(function (x) {
                        statusNginx.play();
                    })
                    .debounce(2000)
                    .subscribe(function (x) {
                        statusNginx.pause();
                    });
                self.on('unmount', function () { this.dispose(); }.bind(subscription));

                // tcpdump console
                subscription = demoTcpdumpSource
                    .do(function (x) { console.debug('tcpdump:', x); })
                    .map(function (x) {
                        let line = document.createElement('div');
                        line.innerText = JSON.stringify(x);
                        return line;
                    })
                    .subscribe(function (x) {
                        consoleTcpdump.add(x);
                        self.update();
                    });
                self.on('unmount', function () { this.dispose(); }.bind(subscription));
                // tcpdump available
                subscription = demoTcpdumpSource
                    .do(function (x) { console.debug('tcpdump:', x); })
                    .do(function (x) {
                        statusTcpdump.play();
                    })
                    .debounce(2000)
                    .subscribe(function (x) {
                        statusTcpdump.pause();
                    });
                self.on('unmount', function () { this.dispose(); }.bind(subscription));


            })
    </script>
</se>