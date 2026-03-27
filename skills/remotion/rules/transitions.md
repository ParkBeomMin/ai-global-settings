---
name: transitions
description: Scene transitions and overlays using TransitionSeries
---

## Prerequisites

```bash
npx remotion add @remotion/transitions
```

## TransitionSeries

Two enhancement modes at cut points:
- **Transitions** — crossfade, slide, wipe (shortens timeline)
- **Overlays** — render effects on top (no timeline change)

```tsx
import { TransitionSeries, linearTiming } from "@remotion/transitions";
import { fade } from "@remotion/transitions/fade";

<TransitionSeries>
  <TransitionSeries.Sequence durationInFrames={60}><SceneA /></TransitionSeries.Sequence>
  <TransitionSeries.Transition
    presentation={fade()}
    timing={linearTiming({ durationInFrames: 15 })}
  />
  <TransitionSeries.Sequence durationInFrames={60}><SceneB /></TransitionSeries.Sequence>
</TransitionSeries>
```

## Available transitions

```tsx
import { fade } from "@remotion/transitions/fade";
import { slide } from "@remotion/transitions/slide";
import { wipe } from "@remotion/transitions/wipe";
import { flip } from "@remotion/transitions/flip";
import { clockWipe } from "@remotion/transitions/clock-wipe";
```

Slide directions: `"from-left"`, `"from-right"`, `"from-top"`, `"from-bottom"`

## Timing options

```tsx
linearTiming({ durationInFrames: 20 });
springTiming({ config: { damping: 200 }, durationInFrames: 25 });
```

## Duration calculation

Transitions overlap, so total = sum of sequences - sum of transitions.
Overlays do NOT affect total duration.

```tsx
const totalDuration = scene1 + scene2 + scene3 - transition1 - transition2;
```

Use `timing.getDurationInFrames({ fps })` to get computed duration.

## Overlays

An overlay cannot be adjacent to a transition or another overlay.

```tsx
<TransitionSeries.Overlay durationInFrames={20}>
  <LightLeak />
</TransitionSeries.Overlay>
```
