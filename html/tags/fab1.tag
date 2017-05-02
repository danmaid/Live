<fab1>
    <yield from="menu" />
    <yield/>

    <style>
         :scope {
            position: absolute;
        }
        
         :scope:hover button {
            opacity: 1;
            display: inline-block;
            transform: none;
        }
        
        button {
            border-radius: 50%;
            border: none;
            width: 32px;
            height: 32px;
            font-size: 16px;
            background-color: #3F51B5;
            color: #fff;
            cursor: pointer;
            opacity: 0;
            display: none;
        }
        
        .menu {
            width: 32px;
            height: 32px;
            font-size: 16px;
            background-color: #E91E63;
            color: #fff;
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
    </style>
</fab1>