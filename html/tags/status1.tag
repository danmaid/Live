<status1>
    <div class="value">{ value }</div>
    <div class="gear" style={ style }>
        <div class="bar"></div>
        <div class="bar"></div>
        <div class="bar"></div>
        <div class="bar"></div>
    </div>
    
    <style>
         :scope {
            display: flex;
            position: absolute;
            width: 50px;
            height: 50px;
            justify-content: center;
            align-items: center;
            color: hsla(226, 100%, 70%, 1);
            font-size: 12px;
        }

        .value {
            z-index: 999;
        }

        .gear {
            position: absolute;
            width: 100%;
            height: 100%;
            background-color: hsla(226, 100%, 20%, 0.65);
            border: 1px solid;
            border-radius: 50%;
            border-color: hsla(226, 100%, 70%, 0.65);
            transition: transform 2s linear;
        }
        .gear:hover {
            transform: rotate(45deg);
        }

        .bar {
            position: absolute;
            width: 10%;
            height: 20%;
            border: 1px solid;
            border-color: hsla(226, 100%, 70%, 0.65);
            border-right: none;
            background-color: hsla(226, 100%, 70%, 0.65);
        }
        .bar:nth-child(1) {
            left: -10%;
            top: 40%;
        }
        .bar:nth-child(2) {
            left: 45%;
            top: calc(-20% + 1px);
            transform: rotate(90deg);
        }
        .bar:nth-child(3) {
            right: -10%;
            top: 40%;
            transform: rotate(180deg);
        }
        .bar:nth-child(4) {
            right: 45%;
            bottom: calc(-20% + 1px);
            transform: rotate(270deg);
        }
    </style>

    <script>
        this.value = 0
        this.turn = 0

        this.change = function (x) {
            this.trigger('change', x)
        }

        this.on('change', function (x) {
            console.log('change')
            console.log(x)
            this.value = x
            this.turn += x / 50
            this.style = {
                transform: 'rotate(' + this.turn + 'turn)',
            }
            this.update()
        })
    </script>
</status1>
