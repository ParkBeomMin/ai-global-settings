---
name: trimming
description: Trimming patterns - cut the beginning or end of animations
---

## Trim the beginning

Negative `from` shifts time backwards:

```tsx
const { fps } = useVideoConfig();

<Sequence from={-0.5 * fps}>
  <MyAnimation />
</Sequence>
```

Inside, `useCurrentFrame()` starts at the offset value instead of 0.

## Trim the end

```tsx
<Sequence durationInFrames={1.5 * fps}>
  <MyAnimation />
</Sequence>
```

## Trim and delay (nest sequences)

```tsx
<Sequence from={30}>
  <Sequence from={-15}>
    <MyAnimation />
  </Sequence>
</Sequence>
```

Inner trims 15 frames from start, outer delays by 30 frames.
