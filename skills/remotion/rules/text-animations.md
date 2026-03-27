---
name: text-animations
description: Typography and text animation patterns for Remotion
---

## Typewriter effect

Use string slicing based on `useCurrentFrame()`. Never use per-character opacity.

```tsx
const frame = useCurrentFrame();
const { fps } = useVideoConfig();
const text = "Hello World";
const charsShown = Math.floor(interpolate(frame, [0, 2 * fps], [0, text.length], { extrapolateRight: "clamp" }));

return <div>{text.slice(0, charsShown)}</div>;
```

## Word highlighting

Animate a highlight (like a highlighter pen) by expanding width over the target word using `interpolate`.
