<fab1>
    <yield from="menu" />
    <yield/>

    <style scoped>
        button {
            border-radius: 50%;
            border: none;
            width: 40px;
            height: 40px;
            font-size: 24px;
            background-color: #3F51B5;
            color: #fff;
            cursor: pointer;
            opacity: 0;
            display: none;
        }
        
        .menu {
            width: 56px;
            height: 56px;
            font-size: 24px;
            background-color: #E91E63;
            color: #fff;
            opacity: 1;
            display: inline-block;
            transform: none;
        }
        
        fab1:hover button {
            opacity: 1;
            display: inline-block;
            transform: none;
        }
        
        [tooltip]:before {
            border-radius: 2px;
            background: #585858;
            color: #fff;
            content: attr(tooltip);
            font-size: 12px;
            visibility: hidden;
            opacity: 0;
            padding: 5px 7px;
            position: absolute;
            bottom: 100%;
            white-space: nowrap;
        }
        
        [tooltip]:hover:before,
        [tooltip]:hover:after {
            visibility: visible;
            opacity: 1;
        }

        @import url(https://fonts.googleapis.com/css?family=Roboto:100,200,300,400,500);
        .buttons {
            box-shadow: 0px 5px 11px -2px rgba(0, 0, 0, 0.18), 0px 4px 12px -7px rgba(0, 0, 0, 0.15);
            border-radius: 50%;
            display: block;
            width: 56px;
            height: 56px;
            margin: 20px auto 0;
            position: relative;
            -webkit-transition: all .1s ease-out;
            transition: all .1s ease-out;
        }
        
        .buttons:active,
        .buttons:focus,
        .buttons:hover {
            box-shadow: 0 0 4px rgba(255, 255, 255, .14), 0 4px 8px rgba(255, 255, 255, .28);
        }
        
        .buttons:not(:last-child) {
            width: 40px;
            height: 40px;
            margin: 20px auto 0;
            opacity: 0;
            -webkit-transform: translateY(50px);
            -ms-transform: translateY(50px);
            transform: translateY(50px);
        }
        
        .container:hover .buttons:not(:last-child) {
            opacity: 1;
            -webkit-transform: none;
            -ms-transform: none;
            transform: none;
            margin: 15px auto 0;
        }
        /* Unessential styling for sliding up buttons at differnt speeds */
        
        .buttons:nth-last-child(1) {
            -webkit-transition-delay: 25ms;
            transition-delay: 25ms;
            background-image: url('http://cbwconline.com/IMG/Share.svg');
            background-size: contain;
        }
        
        .buttons:not(:last-child):nth-last-child(2) {
            -webkit-transition-delay: 50ms;
            transition-delay: 20ms;
            background-image: url('http://cbwconline.com/IMG/Facebook-Flat.png');
            background-size: contain;
        }
        
        .buttons:not(:last-child):nth-last-child(3) {
            -webkit-transition-delay: 75ms;
            transition-delay: 40ms;
            background-image: url('http://cbwconline.com/IMG/Twitter-Flat.png');
            background-size: contain;
        }
        
        .buttons:not(:last-child):nth-last-child(4) {
            -webkit-transition-delay: 100ms;
            transition-delay: 60ms;
            background-image: url('http://cbwconline.com/IMG/Google%20Plus.svg');
            background-size: contain;
        }
        /* Show tooltip content on hover */
        
    </style>
</fab1>