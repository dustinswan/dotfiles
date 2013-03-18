var pushLeftHalf = slate.operation("push", {
  "direction" : "left",
  "style" : "bar-resize:screenSizeX/2"
});

var pushLeftThird = slate.operation("push", {
  "direction" : "left",
  "style" : "bar-resize:screenSizeX/3"
});

var pushRightHalf = slate.operation("push", {
  "direction" : "right",
  "style" : "bar-resize:screenSizeX/2"
});

var pushRightThird = slate.operation("push", {
  "direction" : "right",
  "style" : "bar-resize:screenSizeX/3"
});

slate.bind("left:ctrl,alt,cmd", pushLeftHalf);
slate.bind("left:ctrl,alt,cmd,shift", pushLeftThird);
slate.bind("right:ctrl,alt,cmd", pushRightHalf);
slate.bind("right:ctrl,alt,cmd,shift", pushRightThird);
