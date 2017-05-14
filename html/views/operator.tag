<operator>
    <gauge3 data-max="100" data-min="0" data-value={ cpu }>CPU</gauge3>
    <gauge3 data-max="100" data-min="0" data-value={ memory }>Memory</gauge3>

    <style>
        gauge3 {
            width: 10em;
        }
    </style>

    <script>
        self = this;
        // 初期値を指定。なくても大丈夫。
        this.cpu = 50;
        this.memory = 50;

        // ゲージをマウント
        riot.mount('gauge3');

        // CPU 使用率ストリーム
        subscription = demo6901source
            .filter(function(x) {
                return 'cpu' == x.name && 0 <= x.fields.usage_user && 0 <= x.fields.usage_system
            })
            // .do(function(x) { console.debug('cpu:', x); })
            .subscribe(function (x) {
                self.cpu = x.fields.usage_user + x.fields.usage_system;
                self.update();
            });
        // View切り替え用解放処理。場合によっては不要。
        this.on('unmount', function () { this.dispose(); }.bind(subscription));

        // Memory 使用率ストリーム
        subscription = demo6901source
            .filter(function(x) {
                return x.name == 'mem' && x.fields.used_percent;
            })
            // .do(function(x) { console.debug('memory:', x); })
            .subscribe(function (x) {
                self.memory = x.fields.used_percent;
                self.update();
            });
        // View切り替え用解放処理。場合によっては不要。
        this.on('unmount', function () { this.dispose(); }.bind(subscription));
        
    </script>
</operator>