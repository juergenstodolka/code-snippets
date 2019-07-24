'use strict';

const Readable = require('stream').Readable;

class TemperatureReader extends Readable {

    constructor (opt) {
        opt = opt || {};
        opt.objectMode = true;
        super(opt);
        this.itmes = 0;
        this.maxitems = 10;
    }

    _read () {
        if (this.itmes++ < this.maxitems) {
            this.push({
                date: new Date(2019, 7, this.itmes + 1),
                temp: Math.floor(Math.random() * 1000 - 273) + '°C'
            });
        }
        else {
            this.push(null);
        }
    }
}

const tr = new TemperatureReader();
let tempObj;

tr.on('readable', function () {
    while (null !== (tempObj = tr.read())) {
        console.log(JSON.stringify(tempObj));
    }
});