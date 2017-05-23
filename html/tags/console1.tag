<console1>
    <yield/>

    <style>
         :scope {
            display: block;
            position: absolute;
            font-size: 12px;
            width: 40em;
            height: 24em;
            line-height: 1.1em;
            background-color: hsla(226, 100%, 20%, 0.65);
            border: 1px solid;
            border-color: hsla(226, 100%, 70%, 0.65);
            color: hsla(226, 100%, 70%, 1);
            padding: 0.2em;
            overflow: hidden;
            white-space: nowrap;
        }
        
         :scope * {
            transition: color 1s;
        }
    </style>

    <script>
        this.add = function (x) { this.trigger('add', x) }

        this.on('add', function (tag) {
            tag.style.color = '#fff'
            this.root.appendChild(tag)
            this.root.scrollTop = this.root.scrollHeight
            tag.style.color = null
        })
    </script>
</console1>