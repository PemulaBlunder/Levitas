// ====== CONFIG ======
const canvas = document.getElementById("game");
const ctx = canvas.getContext("2d");

const scoreEl = document.getElementById("score");
const bestEl = document.getElementById("best");
const statusEl = document.getElementById("status");

const btnStart = document.getElementById("btnStart");
const btnPause = document.getElementById("btnPause");
const btnRestart = document.getElementById("btnRestart");

// ukuran grid
const TILE = 20;
const COLS = Math.floor(canvas.width / TILE);
const ROWS = Math.floor(canvas.height / TILE);

// kecepatan (tick per detik)
let TPS = 10; // bisa dinaikkan saat skor naik

// ====== STATE ======
let running = false;
let paused = false;
let gameOver = false;

let score = 0;
let bestScore = Number(localStorage.getItem("snake_best") || 0);
bestEl.textContent = bestScore;

let snake;           // array of {x,y}
let dir;             // {x,y}
let nextDir;         // {x,y} (untuk mencegah balik arah instan)
let food;            // {x,y}

// timing loop
let lastTime = 0;
let acc = 0;

// ====== HELPERS ======
function setStatus(text) {
  statusEl.textContent = text;
}

function randCell() {
  return {
    x: Math.floor(Math.random() * COLS),
    y: Math.floor(Math.random() * ROWS),
  };
}

function sameCell(a, b) {
  return a.x === b.x && a.y === b.y;
}

function isSnakeCell(cell) {
  return snake.some(s => sameCell(s, cell));
}

function spawnFood() {
  let f = randCell();
  while (isSnakeCell(f)) f = randCell();
  food = f;
}

function resetGame() {
  score = 0;
  scoreEl.textContent = score;

  TPS = 10;
  running = false;
  paused = false;
  gameOver = false;

  // snake mulai di tengah
  const start = { x: Math.floor(COLS / 2), y: Math.floor(ROWS / 2) };
  snake = [
    { x: start.x, y: start.y },
    { x: start.x - 1, y: start.y },
    { x: start.x - 2, y: start.y },
  ];

  dir = { x: 1, y: 0 };
  nextDir = { x: 1, y: 0 };

  spawnFood();
  setStatus("Ready");
  draw(); // render awal
}

function endGame() {
  gameOver = true;
  running = false;
  setStatus("Game Over");

  if (score > bestScore) {
    bestScore = score;
    localStorage.setItem("snake_best", String(bestScore));
    bestEl.textContent = bestScore;
  }
}

// ====== INPUT ======
function setDirection(newDir) {
  // cegah balik arah: tidak boleh (x,y) = (-dir.x, -dir.y)
  if (newDir.x === -dir.x && newDir.y === -dir.y) return;
  nextDir = newDir;
}

window.addEventListener("keydown", (e) => {
  const k = e.key.toLowerCase();

  if (k === "arrowup" || k === "w") setDirection({ x: 0, y: -1 });
  else if (k === "arrowdown" || k === "s") setDirection({ x: 0, y: 1 });
  else if (k === "arrowleft" || k === "a") setDirection({ x: -1, y: 0 });
  else if (k === "arrowright" || k === "d") setDirection({ x: 1, y: 0 });
  else if (k === "p") togglePause();
  else if (k === "r") {
    resetGame();
    startGame();
  }
});

btnStart.addEventListener("click", startGame);
btnPause.addEventListener("click", togglePause);
btnRestart.addEventListener("click", () => {
  resetGame();
  startGame();
});

// ====== GAME LOOP ======
function startGame() {
  if (gameOver) resetGame();
  if (!running) {
    running = true;
    paused = false;
    setStatus("Playing");
    lastTime = performance.now();
    requestAnimationFrame(loop);
  }
}

function togglePause() {
  if (!running && !paused) return;
  paused = !paused;
  if (paused) {
    setStatus("Paused");
  } else {
    setStatus("Playing");
    lastTime = performance.now();
    requestAnimationFrame(loop);
  }
}

function loop(now) {
  if (!running || paused) return;

  const dt = (now - lastTime) / 1000;
  lastTime = now;

  acc += dt;
  const step = 1 / TPS;

  while (acc >= step) {
    update();
    acc -= step;
    if (gameOver) break;
  }

  draw();

  if (!gameOver) requestAnimationFrame(loop);
}

// ====== UPDATE ======
function update() {
  dir = nextDir;

  const head = snake[0];
  const newHead = { x: head.x + dir.x, y: head.y + dir.y };

  // tabrak tembok
  if (newHead.x < 0 || newHead.x >= COLS || newHead.y < 0 || newHead.y >= ROWS) {
    endGame();
    return;
  }

  // tabrak badan sendiri
  if (snake.some((seg, idx) => idx !== 0 && sameCell(seg, newHead))) {
    endGame();
    return;
  }

  // maju
  snake.unshift(newHead);

  // makan?
  if (sameCell(newHead, food)) {
    score += 10;
    scoreEl.textContent = score;

    // scaling speed ringan
    if (score % 50 === 0) TPS += 1;

    spawnFood();
  } else {
    // kalau tidak makan, ekor dipotong
    snake.pop();
  }
}

// ====== RENDER ======
function drawGrid() {
  ctx.strokeStyle = "rgba(29,42,74,.35)";
  ctx.lineWidth = 1;

  for (let x = 0; x <= COLS; x++) {
    ctx.beginPath();
    ctx.moveTo(x * TILE, 0);
    ctx.lineTo(x * TILE, canvas.height);
    ctx.stroke();
  }
  for (let y = 0; y <= ROWS; y++) {
    ctx.beginPath();
    ctx.moveTo(0, y * TILE);
    ctx.lineTo(canvas.width, y * TILE);
    ctx.stroke();
  }
}

function draw() {
  // background
  ctx.fillStyle = "#081022";
  ctx.fillRect(0, 0, canvas.width, canvas.height);

  // grid (opsional, bisa dihapus kalau mau lebih clean)
  drawGrid();

  // food
  ctx.fillStyle = "#ff3d5a";
  ctx.beginPath();
  ctx.roundRect(food.x * TILE + 3, food.y * TILE + 3, TILE - 6, TILE - 6, 6);
  ctx.fill();

  // snake
  snake.forEach((seg, i) => {
    ctx.fillStyle = i === 0 ? "#7cff6b" : "#2ee59d";
    ctx.beginPath();
    ctx.roundRect(seg.x * TILE + 2, seg.y * TILE + 2, TILE - 4, TILE - 4, 6);
    ctx.fill();
  });

  // overlay game over
  if (gameOver) {
    ctx.fillStyle = "rgba(0,0,0,.55)";
    ctx.fillRect(0, 0, canvas.width, canvas.height);
    ctx.fillStyle = "#ffffff";
    ctx.font = "bold 26px ui-sans-serif, system-ui";
    ctx.textAlign = "center";
    ctx.fillText("GAME OVER", canvas.width / 2, canvas.height / 2 - 10);
    ctx.font = "14px ui-sans-serif, system-ui";
    ctx.fillText("Tekan R untuk restart", canvas.width / 2, canvas.height / 2 + 18);
  }
}

// polyfill kecil untuk roundRect jika browser lama
if (!CanvasRenderingContext2D.prototype.roundRect) {
  CanvasRenderingContext2D.prototype.roundRect = function (x, y, w, h, r) {
    r = Math.min(r, w / 2, h / 2);
    this.beginPath();
    this.moveTo(x + r, y);
    this.arcTo(x + w, y, x + w, y + h, r);
    this.arcTo(x + w, y + h, x, y + h, r);
    this.arcTo(x, y + h, x, y, r);
    this.arcTo(x, y, x + w, y, r);
    this.closePath();
    return this;
  };
}

// ====== INIT ======
resetGame();