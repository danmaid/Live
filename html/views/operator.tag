<operator>
    <gauge3 class="compile" data-max="100" data-min="0" data-value={ cpu }>CPU</gauge3>
    <gauge3 class="compile" data-max="100" data-min="0" data-value={ memory }>Memory</gauge3>

    <div class="explanation">
        <h2>解説</h2>
        <p>表示用タグ。最大値、最小値、現在値、タイトルを指定。</p>
        <pre><code class="html">&lt;gauge3 data-max="100" data-min="0" data-value={ cpu }&gt;CPU&lt;/gauge3&gt;
&lt;gauge3 data-max="100" data-min="0" data-value={ memory }&gt;Memory&lt;/gauge3&gt;</code></pre>
        <p>ストリームからの値を元に、現在値を更新する。</p>
        <pre><code id="code1" class="javascript"></code></pre>
    </div>

    <style>
        gauge3 {
            width: 10em;
        }

        .explanation {
            /*position: absolute;
            right:0;
            top: 0;*/
            margin: 0.5em;
            padding: 0.5em;
            border: 1px solid;
            background-color: hsla(226, 100%, 20%, 0.65);
            border-color: hsla(226, 100%, 70%, 0.65);
            color: hsla(226, 100%, 70%, 1);
        }

        .explanation h2 {
            font-size: 1.2rem;
        }

        .explanation .html, .explanation .javascript {
            border: 1px solid;
            border-color: hsla(226, 100%, 70%, 0.65);
        }

        .explanation p, pre {
            margin: 0;
        }

    </style>

    <script>
        self = this;
        // 初期値を指定。なくても大丈夫。
        this.cpu = 50;
        this.memory = 50;

        // CPU 使用率ストリーム
        subscription = demo6901source
            .filter(function (x) {
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
            .filter(function (x) {
                return x.name == 'mem' && x.fields.used_percent;
            })
            // .do(function(x) { console.debug('memory:', x); })
            .subscribe(function (x) {
                self.memory = x.fields.used_percent;
                self.update();
            });
        // View切り替え用解放処理。場合によっては不要。
        this.on('unmount', function () { this.dispose(); }.bind(subscription));

        this.on('mount', function () {
            contents = 'demo6901source\n' +
                '  .filter(function (x) {\n' + 
                '  return \'cpu\' == x.name && 0 <= x.fields.usage_user && 0 <= x.fields.usage_system\n' +
                '})\n' + 
                '.subscribe(function (x) {\n' +
                '  self.cpu = x.fields.usage_user + x.fields.usage_system;\n' +
                '  self.update();\n' +
                '});'
            document.getElementById('code1').innerHTML = contents;
            hljs.initHighlighting();
        });

    </script>
</operator>

