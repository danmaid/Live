<gauge2>
    <div class="gauge" style={ style }></div>
    <div class="value">{ value }</div>

    <style>
         :scope {
            position: absolute;
            width: 20px;
            height: 100px;
            background-color: rgba(255, 255, 255, .2);
            transition: all 1s;
            color: rgba(255, 255, 255, 1);
        }
        
        .gauge {
            background-color: #5664F9;
            width: 100%;
            height: 50%;
            position: absolute;
            bottom: 0;
        }
        
        .value {
            font-size: 12px;
            position: absolute;
            bottom: 0;
            right: 0;
        }
        
    </style>
    <script>
        this.min = 0
        this.max = 100
        this.value = 50

        this.on('update', function () {
            console.log(this)
            this.style = {
                height: (this.value * 2) + '%'
            }
        })
    </script>
</gauge2>