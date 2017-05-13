<!--
    example1:
    <barbar></barbar>

    example2:
    <barbar id="bar1" style="top:152px; left: 204px; width: 60px; transform: rotate(90deg);"></barbar>

    example-update:
    var tag = riot.mount('barbar')[0]
    tag.update({ value: x })

    valueに与えた値がアニメーションスピードになる。単位はs
    animation: barbar 4←ココs linear infinite;
    
 -->
<barbar>
    <div class="barbar" style={ style }></div>
    <style>
         :scope {
            position: absolute;
            width: 320px;
            height: 20px;
        }
        
        .barbar {
            font-size: 10px;
            width: 100%;
            height: 100%;
            border-radius: 3em;
            box-shadow: 1em 0 1em 0 rgba(0, 0, 0, 0.5) inset, 0 0 0.5em 0.25em rgba(0, 0, 0, 0.5) inset, 0 0 1em 0.5em rgba(0, 0, 0, 0.5) inset, 0 0 0 0 transparent;
            background: #fff 0 0 repeat;
            background-size: 100% 800%;
            background-image: linear-gradient(60deg, #f00 0, #f00 2em, #fff 0, #fff 4em, #00f 0, #00f 6em, #fff 0, #fff 8em, #f00 0, #f00 10em, #fff 0, #fff 12em, #00f 0, #00f 14em, #fff 0, #fff 16em, #f00 0, #f00 18em, #fff 0, #fff 20em, #00f 0, #00f 22em, #fff 0, #fff 24em, #f00 0, #f00 26em, #fff 0, #fff 28em, #00f 0, #00f 30em, #fff 0, #fff 32em, #f00 0, #f00 34em, #fff 0, #fff 36em, #00f 0, #00f 38em, #fff 0, #fff 40em, transparent);
        }
        
        @keyframes barbar {
            100% {
                background-position: 0 -16em;
            }
        }
    </style>
    <script>
        this.on('update', function () {
            this.style = {
                'animation': 'barbar ' + this.value + 's linear infinite'
            }
        })
    </script>
</barbar>