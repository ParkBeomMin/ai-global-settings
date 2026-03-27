---
name: timing
description: Interpolation curves in Remotion - linear, easing, spring animations
---

## Linear interpolation

```ts
import { interpolate } from "remotion";

const opacity = interpolate(frame, [0, 100], [0, 1], {
  extrapolateRight: "clamp",
  extrapolateLeft: "clamp",
});
```

## Spring animations

Springs go from 0 to 1 with natural motion.

```ts
import { spring, useCurrentFrame, useVideoConfig } from "remotion";

const frame = useCurrentFrame();
const { fps } = useVideoConfig();

const scale = spring({ frame, fps });
```

Default config: `mass: 1, damping: 10, stiffness: 100` (slight bounce).

Common configurations:

```tsx
const smooth = { damping: 200 };                          // No bounce
const snappy = { damping: 20, stiffness: 200 };           // Minimal bounce
const bouncy = { damping: 8 };                             // Playful bounce
const heavy  = { damping: 15, stiffness: 80, mass: 2 };   // Heavy, slow
```

### Delay and duration

```tsx
spring({ frame, fps, delay: 20 });
spring({ frame, fps, durationInFrames: 40 });
```

### Combining spring with interpolate

```tsx
const springProgress = spring({ frame, fps });
const rotation = interpolate(springProgress, [0, 1], [0, 360]);
```

### In/out pattern

```tsx
const inAnim = spring({ frame, fps });
const outAnim = spring({ frame, fps, durationInFrames: 1 * fps, delay: durationInFrames - 1 * fps });
const scale = inAnim - outAnim;
```

## Easing

```ts
import { interpolate, Easing } from "remotion";

const value = interpolate(frame, [0, 100], [0, 1], {
  easing: Easing.inOut(Easing.quad),
  extrapolateLeft: "clamp",
  extrapolateRight: "clamp",
});
```

Convexities: `Easing.in`, `Easing.out`, `Easing.inOut`
Curves (linear → curved): `Easing.quad`, `Easing.sin`, `Easing.exp`, `Easing.circle`
Cubic bezier: `Easing.bezier(0.8, 0.22, 0.96, 0.65)`
