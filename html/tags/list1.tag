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
        this.add = function (key, element) { this.trigger('add', key, element) }
        this.remove = function (key) { this.trigger('remove', key) }
        this.change = function (key, element) { this.trigger('change', key, element) }
        this.count = function() { return this.root.childElementCount }
        
        this.child = {}

        this.on('add', function (key, element) {
            element.style.color = '#fff'
            if (this.child[key]) { this.remove(key) }
            this.child[key] = element
            this.root.appendChild(element)
            this.root.scrollTop = this.root.scrollHeight
            element.style.color = null
        })

        this.on('remove', function(key) {
            this.root.removeChild(this.child[key])
        })

    </script>
</list1>