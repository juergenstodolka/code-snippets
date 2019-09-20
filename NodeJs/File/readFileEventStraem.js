'use strict';

const es = require('event-stream');
const fs = require('fs');
const now = require('performance-now');

let totalLines = 0;

/*
 Use event-stream to read  big files.
*/
let t0;

try {
    let s = fs.createReadStream('statistics.log')
        .pipe(es.split())
        .pipe(
            es
                .mapSync(function (line) {
                    t0 = now();
                    console.time('line count');
                    totalLines++;

                    const field = line.split(';');
                    const [
                        PLO_PLSNR, PLS_PLOTID, PLS_SRCNODE, PLS_USERNAME, PLS_PLOTTYPE, PLS_PLOTPAPER, PLS_PLOTPEN,
                        PLO_PAGE_COUNT, PLO_SIZEX, PLO_SIZEY, PLO_DINFORMAT,
                        PLS_SCALE_TYPE, PLS_PLOTSCALE, PLO_SCALE, PLO_ITEMS,
                        PLO_VECTORS, PLO_BYTES, PLO_PLOTTER, PLS_PLOTDATE, PLO_START, PLO_END
                    ] = field;

                    //  console.log(`PLS_PLOTID=${PLS_PLOTID}, PLO_BYTES=${PLO_BYTES}, PLS_PLOTDATE=${PLS_PLOTDATE}, PLS_PLOTDATE=${PLS_PLOTDATE}, PLO_START=${PLO_START}, PLO_END=${PLO_END}`);
                })
                .on('error', function (err) {
                    console.log('Error while reading file.', err);
                })
                .on('end', function () {
                    let t1 = now();
                    console.log('Read entire file.');
                    console.log('Total lines:', totalLines);
                    console.timeEnd('line count');
                    console.log(`Performance now line count timing: ` + (t1 - t0).toFixed(3));
                })
        );

} catch (error) {
    console.error('EXCEPTION caught:', error);
}