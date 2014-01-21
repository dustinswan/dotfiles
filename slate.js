var pushLeftHalf = slate.operation("push", {
  "direction" : "left",
  "style" : "bar-resize:screenSizeX/2"
});

var pushLeftThird = slate.operation("push", {
  "direction" : "left",
  "style" : "bar-resize:2 * screenSizeX/3"
});

var pushRightHalf = slate.operation("push", {
  "direction" : "right",
  "style" : "bar-resize:screenSizeX/2"
});

var pushRightThird = slate.operation("push", {
  "direction" : "right",
  "style" : "bar-resize:screenSizeX/3"
});

var pushUpHalf = slate.operation("push", {
  "direction" : "up",
  "style" : "bar-resize:screenSizeY/2"
});

var pushDownHalf = slate.operation("push", {
  "direction" : "down",
  "style" : "bar-resize:screenSizeY/2"
});

var pushFull = slate.operation("push", {
  "direction" : "up",
  "style" : "bar-resize:screenSizeX"
});

slate.bind("left:ctrl,alt,cmd", pushLeftHalf);
slate.bind("left:ctrl,alt,cmd,shift", pushLeftThird);
slate.bind("right:ctrl,alt,cmd", pushRightHalf);
slate.bind("right:ctrl,alt,cmd,shift", pushRightThird);

slate.bind("up:ctrl,alt,cmd", pushUpHalf);
slate.bind("down:ctrl,alt,cmd", pushDownHalf);
slate.bind("up:shift,ctrl,alt,cmd", pushFull);
