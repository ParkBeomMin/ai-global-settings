---
name: sequencing
description: Sequencing patterns for Remotion - delay, trim, limit duration
---

## Sequence

Use `<Sequence>` to delay when an element appears.

```tsx
import { Sequence, useVideoConfig } from "remotion";

const { fps } = useVideoConfig();

<Sequence from={1 * fps} durationInFrames={2 * fps} premountFor={1 * fps}>
  <Title />
</Sequence>
```

By default wraps in an absolute fill. Use `layout="none"` to prevent wrapping.

### Premounting

Always premount `<Sequence>` containing `<Video>`:

```tsx
<Sequence premountFor={1 * fps}>
  <Title />
</Sequence>
```

### Frame references

Inside a Sequence, `useCurrentFrame()` returns the **local** frame (starting from 0).

## Series

Use `<Series>` for elements that play one after another:

```tsx
import { Series } from "remotion";

<Series>
  <Series.Sequence durationInFrames={45}><Intro /></Series.Sequence>
  <Series.Sequence durationInFrames={60}><MainContent /></Series.Sequence>
  <Series.Sequence durationInFrames={30}><Outro /></Series.Sequence>
</Series>
```

Negative offset for overlapping sequences:

```tsx
<Series.Sequence offset={-15} durationInFrames={60}>
  <SceneB />
</Series.Sequence>
```

## Nested Sequences

```tsx
<Sequence from={0} durationInFrames={120}>
  <Background />
  <Sequence from={15} durationInFrames={90} layout="none"><Title /></Sequence>
  <Sequence from={45} durationInFrames={60} layout="none"><Subtitle /></Sequence>
</Sequence>
```

## Nesting compositions

```tsx
<AbsoluteFill>
  <Sequence width={COMPOSITION_WIDTH} height={COMPOSITION_HEIGHT}>
    <CompositionComponent />
  </Sequence>
</AbsoluteFill>
```
