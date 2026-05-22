// Perlin noise flow field
// Every particle follows a direction determined by noise — a math function that
// produces smooth, organic-looking randomness. The same algorithm generates
// terrain in video games, smoke in CGI, and market simulations in finance.
//
// Try tweaking these numbers while it runs:

const PARTICLE_COUNT = 900;
const NOISE_SCALE    = 0.0022;   // lower = smoother flows, higher = more chaotic
const SPEED          = 1.6;
const TRAIL_ALPHA    = 18;        // lower = longer trails
const STROKE_COLOR   = [72, 190, 255];
const STROKE_ALPHA   = 130;

let particles = [];

function setup() {
  createCanvas(windowWidth, windowHeight);
  strokeWeight(1.2);

  for (let i = 0; i < PARTICLE_COUNT; i++) {
    particles.push(createVector(random(width), random(height)));
  }

  background(8, 8, 20);
}

function draw() {
  // Semi-transparent fill creates the trailing effect
  background(8, 8, 20, TRAIL_ALPHA);

  stroke(STROKE_COLOR[0], STROKE_COLOR[1], STROKE_COLOR[2], STROKE_ALPHA);

  for (let p of particles) {
    // noise() returns a value in [0, 1] — we scale it into an angle
    const angle = noise(p.x * NOISE_SCALE, p.y * NOISE_SCALE, frameCount * 0.0007) * TWO_PI * 3;

    p.x += cos(angle) * SPEED;
    p.y += sin(angle) * SPEED;

    point(p.x, p.y);

    // Respawn off-screen particles at a random edge
    if (p.x < 0 || p.x > width || p.y < 0 || p.y > height) {
      p.set(random(width), random(height));
    }
  }
}

function windowResized() {
  resizeCanvas(windowWidth, windowHeight);
}
