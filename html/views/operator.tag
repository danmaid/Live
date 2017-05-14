<operator>
    <gauge3 data-max="100" data-min="0" data-value={ cpu }>CPU</gauge3>
    <gauge3 data-max="100" data-min="0" data-value={ memory }>Memory</gauge3>

    <button onclick={ click }>Update</button>

    <style>
        gauge3 {
            width: 10em;
        }
    </style>

    <script>
        this.cpu = 0;
        this.memory = 0;
        riot.mount('gauge3');

        click(e) {
            this.cpu = 80;
            this.memory = 50;
        }
    </script>
</operator>