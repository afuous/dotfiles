#!/usr/bin/env node


// https://emacs.stackexchange.com/questions/39019/xclip-hangs-shell-command
// https://unix.stackexchange.com/questions/316715/xclip-works-differently-in-interactive-and-non-interactive-shells/320487#320487
// https://askubuntu.com/questions/705620/xclip-vs-xsel/1078667#1078667

// need to use xclip to get input image
// need to use xsel to put output link on the clipboard without hanging


let clientId = require("fs").readFileSync(require("path").join(__dirname, "imgurclientid"));

let req = require("https").request("https://api.imgur.com/3/image?client_id=" + clientId, {
	method: "POST",
}, res => {
	let output = "";
    res.on("data", data => {
        output += data;
    });
	res.on("end", () => {
		let link = JSON.parse(output).data.link;
        console.log(link);
        let proc = require("child_process").spawn("xsel", ["-i", "--clipboard"]);
        proc.stdin.write(link);
        proc.stdin.end();
	});
});

let proc = require("child_process").spawn("xclip", ["-o", "-sel", "clip", "-t", "image/png"]);
proc.stdout.pipe(req);
