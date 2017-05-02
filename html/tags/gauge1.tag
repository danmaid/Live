<gauge1>
    <div class="container">
        <div class="gauge-a"></div>
        <div class="gauge-b"></div>
        <div class="gauge-c" style={ style }></div>
        <div class="gauge-data">
            <h1>{ value }%</h1>
        </div>
    </div>

    <style>
         :scope {
            position: absolute;
        }
        
        .container {
            width: 400px;
            height: 200px;
            position: absolute;
            top: 30%;
            left: 50%;
            overflow: hidden;
            text-align: center;
            transform: translate(-50%, -50%);
        }
        
        .gauge-a {
            z-index: 1;
            position: absolute;
            background-color: rgba(255, 255, 255, .2);
            width: 400px;
            height: 200px;
            top: 0%;
            border-radius: 250px 250px 0px 0px;
        }
        
        .gauge-b {
            z-index: 3;
            position: absolute;
            background-color: #222;
            width: 250px;
            height: 125px;
            top: 75px;
            margin-left: 75px;
            margin-right: auto;
            border-radius: 250px 250px 0px 0px;
        }
        
        .gauge-c {
            z-index: 2;
            position: absolute;
            background-color: #5664F9;
            width: 400px;
            height: 200px;
            top: 200px;
            margin-left: auto;
            margin-right: auto;
            border-radius: 0px 0px 200px 200px;
            transform-origin: center top;
            transition: all 1.3s ease-in-out;
            transform: rotate(0.25turn);
        }
        
        /*.container:hover .gauge-c {
            transform: rotate(0.5turn);
        }
        */
        .container:hover .gauge-data {
            color: rgba(255, 255, 255, 1);
        }
        
        .gauge-data {
            z-index: 4;
            color: rgba(255, 255, 255, .2);
            font-size: 1.5em;
            line-height: 25px;
            position: absolute;
            width: 400px;
            height: 200px;
            top: 90px;
            margin-left: auto;
            margin-right: auto;
            transition: all 1s ease-out;
        }
    </style>
    <script>
        this.min = 0
        this.max = 100
        this.value = 50

        this.on('update', function () {
            console.log(this)
            this.style = {
                transform: 'rotate(' + (0.5 / 100 * this.value) + 'turn)'
            }

        })
    </script>
</gauge1>