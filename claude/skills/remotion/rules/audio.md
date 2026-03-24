---
name: audio
description: Using audio in Remotion - importing, trimming, volume, speed, pitch
---

## Prerequisites

```bash
npx remotion add @remotion/media
```

## Basic usage

```tsx
import { Audio } from "@remotion/media";
import { staticFile } from "remotion";

<Audio src={staticFile("audio.mp3")} />
```

## Trimming (values in frames)

```tsx
const { fps } = useVideoConfig();
<Audio src={staticFile("audio.mp3")} trimBefore={2 * fps} trimAfter={10 * fps} />
```

## Delaying

```tsx
<Sequence from={1 * fps}>
  <Audio src={staticFile("audio.mp3")} />
</Sequence>
```

## Volume

```tsx
<Audio src={staticFile("audio.mp3")} volume={0.5} />
<Audio src={staticFile("audio.mp3")} volume={(f) =>
  interpolate(f, [0, 1 * fps], [0, 1], { extrapolateRight: "clamp" })
} />
```

`f` starts at 0 when audio begins, not the composition frame.

## Muting, Speed, Looping

```tsx
<Audio src={staticFile("audio.mp3")} muted={frame >= 2 * fps} />
<Audio src={staticFile("audio.mp3")} playbackRate={2} />
<Audio src={staticFile("audio.mp3")} loop loopVolumeCurveBehavior="extend" />
```

## Pitch

`toneFrequency` (0.01–2): server-side rendering only.
