<%namespace name="head" file="head.mak" />
${head.head(1020)}
	<div id="explain">Adding mouse support to our game is even simpler;
    all we have to do is send the mousemove event to an onMouseMove
    function, see if the mouse is within the borders of the game,
    and move the paddle if it is.
    <div id="codebox">
       <textarea id="code" rows=10 cols=50>var bricks;
var NROWS = 5;
var NCOLS = 5;
var BRICKWIDTH = (WIDTH/NCOLS) - 1;
var BRICKHEIGHT = 15;
var PADDING = 1;

function initbricks() {
    bricks = new Array(NROWS);
    for (i=0; i &lt; NROWS; i++) {
        bricks[i] = new Array(NCOLS);
        for (j=0; j &lt; NCOLS; j++) {
            bricks[i][j] = 1;
        }
    }
}
       
function draw() {
  clear();
  circle(x, y, 10);

  if (rightDown) paddlex += 5;
  else if (leftDown) paddlex -= 5;
  rect(paddlex, HEIGHT-paddleh, paddlew, paddleh);

  //draw bricks
  for (i=0; i &lt; NROWS; i++) {
    for (j=0; j &lt; NCOLS; j++) {
      if (bricks[i][j] == 1) {
        rect((j * (BRICKWIDTH + PADDING)) + PADDING, 
             (i * (BRICKHEIGHT + PADDING)) + PADDING,
             BRICKWIDTH, BRICKHEIGHT);
      }
    }
  }

  //have we hit a brick?
  rowheight = BRICKHEIGHT + PADDING;
  colwidth = BRICKWIDTH + PADDING;
  row = Math.floor(y/rowheight)
  col = Math.floor(x/colwidth)
  if (y &lt; NROWS * rowheight &amp;&amp; row &gt;= 0 &amp;&amp; col &gt;= 0 &amp;&amp; bricks[row][col] == 1) {
    dy = -dy;
    bricks[row][col] = 0;
  }
 
  if (x + dx &gt; WIDTH || x + dx &lt; 0)
	  dx = -dx;

  if (y + dy &lt; 0)
    dy = -dy;
  else if (y + dy &gt; HEIGHT) {
    if (x &gt; paddlex &amp;&amp; x &lt; paddlex + paddlew)
      dy = -dy;
    else
      clearInterval(intervalId);
  }
 
  x += dx;
  y += dy;
}

initbricks();
init();</textarea>
		</div>
		<input type="submit" value="run code" onclick="runCode()"/><br>
    <p>Try adding code to make the ball bounce in different directions
    based on where it hits the paddle.
    <p>It seems at every step as if what we have is getting closer to
    being a real game, but that it's never quite there. One thing that's
    for sure is that this version of the game is ugly; on the next page
    we'll jazz it up a bit.
    </div>

	   <textarea id="library" style="display: none">
var x = 150;
var y = 150;
var dx = 2;
var dy = 4;
var ctx;
var WIDTH = $("canvas").width()
var HEIGHT = $("canvas").height()
var paddlex = WIDTH / 2;
var paddleh = 10;
var paddlew = 75;
var rightDown = false;
var leftDown = false;
var canvasMinX = 0;
var canvasMaxX = 0;
var intervalId = 0;

function circle(x,y,r) {
  ctx.beginPath();
  ctx.arc(x, y, r, 0, Math.PI*2, true);
  ctx.closePath();
  ctx.fill();
}

function rect(x,y,w,h) {
  ctx.beginPath();
  ctx.rect(x,y,w,h);
  ctx.closePath();
  ctx.fill();
}

function clear() {
  ctx.clearRect(0, 0, WIDTH, HEIGHT);
}

function onKeyDown(evt) {
  if (evt.keyCode == 39) rightDown = true;
  else if (evt.keyCode == 37) leftDown = true;
}

function onKeyUp(evt) {
  if (evt.keyCode == 39) rightDown = false;
  else if (evt.keyCode == 37) leftDown = false;
}

$(document).keydown(onKeyDown);
$(document).keyup(onKeyUp);

function onMouseMove(evt) {
  if (evt.pageX &gt; canvasMinX &amp;&amp; evt.pageX &lt; canvasMaxX) {
    paddlex = evt.pageX - canvasMinX;
  }
}

$(document).mousemove(onMouseMove);

function init() {
  ctx = $('#canvas')[0].getContext("2d");
  canvasMinX = $("#canvas").offset().left;
  canvasMaxX = canvasMinX + $("#canvas").width();
  intervalId = setInterval(draw, 10);
  return intervalId;
}
       </textarea>

${head.next('jazz.html')}
