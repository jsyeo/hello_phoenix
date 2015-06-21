import {Socket} from "phoenix";

let socket = new Socket("/ws");
socket.connect();
let chan = socket.chan("submissions:submit", {});

chan.join().receive("ok", chan => {
  console.log("Success");
});

let $runBtn = $("#runBtn");
let editor = ace.edit("editor");
let $result = $("#result > pre");

$runBtn.on("click", () => {
  chan.push("submission:new", {code: editor.getSession().getValue()});
});

chan.on("submission:done", result => {
  console.log(result.result);
  $result.html(result.result);
});

class App {
}

export default App;
