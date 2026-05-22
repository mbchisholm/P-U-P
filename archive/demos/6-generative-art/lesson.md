# Generative Art and Perlin Noise

This is a flow field — 900 particles, each moving in a direction determined by a noise function sampled at their current position. The result looks organic. That's intentional: the same algorithm generates terrain in video games, smoke in CGI, and turbulence in simulations.

---

## Open It First

```bash
open index.html
```

Let it run for 30 seconds before touching anything. Then we'll start pulling knobs.

---

## The Math in One Paragraph

`noise(x, y)` returns a smooth value between 0 and 1. "Smooth" means nearby inputs give nearby outputs — unlike `random()`, which jumps around. Scale that value into an angle (0 to 2π), and you have a direction. Do that at every pixel and you have a field. Move a particle one step in the field's direction at each frame, and trails form.

```javascript
const angle = noise(p.x * NOISE_SCALE, p.y * NOISE_SCALE, frameCount * 0.0007) * TWO_PI * 3;
p.x += cos(angle) * SPEED;
p.y += sin(angle) * SPEED;
```

The third argument `frameCount * 0.0007` animates the field over time — the noise is slowly evolving, so the flow shifts.

---

## Live Tweaking

Change these while it runs — save, reload, see it immediately:

```javascript
const NOISE_SCALE = 0.0022;   // lower = smoother, larger flows
                               // higher = more chaotic, tight swirls
const SPEED       = 1.6;      // how fast particles move
const TRAIL_ALPHA = 18;       // lower = longer trails (more ghosting)
const STROKE_COLOR = [72, 190, 255];  // RGB
```

Try:
- `NOISE_SCALE = 0.008` — chaotic, almost random-looking
- `NOISE_SCALE = 0.0005` — broad, gentle flows like wind
- `TRAIL_ALPHA = 5` — long ghostly trails
- `STROKE_COLOR = [255, 100, 80]` — coral

This is how you learn a codebase you didn't write: find the constants, break things, understand what each number controls.

---

## The Trailing Effect

```javascript
// In draw(), called every frame:
background(8, 8, 20, TRAIL_ALPHA);
```

Rather than clearing the canvas with an opaque background, this paints a semi-transparent dark rectangle over it every frame. Old particle positions fade slowly instead of disappearing instantly. Lower `TRAIL_ALPHA` = more frames to fade = longer trails.

If you set `TRAIL_ALPHA = 255`, the background is fully opaque and trails disappear entirely. Try it.

---

## The Respawn Logic

```javascript
if (p.x < 0 || p.x > width || p.y < 0 || p.y > height) {
  p.set(random(width), random(height));
}
```

When a particle drifts off screen, it reappears at a random position. Without this, the screen empties out within a few seconds as all particles follow the flow off the edge.

---

## Where This Shows Up

Perlin noise isn't just art. The same algorithm:

- Generates procedural terrain in Minecraft, No Man's Sky, and most open-world games
- Simulates smoke, fire, and water in CGI and VFX
- Models market volatility in quantitative finance (fractional Brownian motion)
- Creates the "organic" texture in fabric and material simulations

The math is the same. What changes is what the output represents.

---

## Hands-On

1. Change `NOISE_SCALE` to `0.008`. Reload. Then try `0.0005`. 
2. Change `TRAIL_ALPHA` to `255`. What happens? Then try `5`.
3. Change `PARTICLE_COUNT` from 900 to 5000. What's the performance cost?
4. Change `SPEED` to `5`. What breaks visually and why?
5. Try adding a second `STROKE_COLOR` and alternating between them based on `frameCount`.

---

## The Three Rules

1. **Constants at the top are an invitation.** They're the interface to the algorithm — tweak them before reading the code.
2. **`noise()` ≠ `random()`.** Noise is smooth and deterministic; random is unpredictable. Use noise when you want organic, use random when you want chaos.
3. **The trailing effect is just opacity.** Semi-transparent backgrounds over time create persistence. It's a trick worth knowing.
