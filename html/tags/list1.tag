<list1>

    <style>
         :scope {
            display: block;
            position: absolute;
            font-size: 12px;
            line-height: 1.1em;
            background-color: hsla(226, 100%, 20%, 0.65);
            border: 1px solid;
            border-color: hsla(226, 100%, 70%, 0.65);
            color: hsla(226, 100%, 70%, 1);
            padding: 0.2em;
            overflow: hidden;
        }
        
         :scope * {
            transition: color 1s;
        }
    </style>
    
    <script>
        // todo: move to mixin
        this.add = function (x) { this.trigger('add', x) }
        this.remove = function (x) { this.trigger('remove', x) }
        this.change = function (x) { this.trigger('change', x) }
        
        this.on('add', function (tag) {
            console.log(tag)
            tag.style.color = '#fff'
            this.root.appendChild(tag)
            tag.style.color = null
        })

        this.on('remove', function(tag) {
            console.log('remove:', tag)
            this.root.removeChild(tag)

        })
    </script>
</list1>