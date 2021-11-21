#!/usr/bin/env node

let input = require("fs").readFileSync(0, "utf-8").toString();

try {
    let obj = JSON.parse(input);
    console.log(JSON.stringify(obj, null, 2));
} catch (e) {
    console.error("error parsing json");
}
