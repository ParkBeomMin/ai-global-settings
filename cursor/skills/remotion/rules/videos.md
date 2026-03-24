---
name: videos
description: Embedding videos - trimming, volume, speed, looping, pitch
---

## Prerequisites

```bash
npx remotion add @remotion/media
```

## Basic usage

```tsx
import { Video } from "@remotion/media";
import { staticFile } from "remotion";

<Video src={staticFile("video.mp4")} />
<Video src="https://remotion.media/video.mp4" />  // Remote URL
```

## Trimming

Values in frames:

```tsx
const { fps } = useVideoConfig();
<Video src={staticFile("video.mp4")} trimBefore={2 * fps} trimAfter={10 * fps} />
```

## Delaying

```tsx
<Sequence from={1 * fps}>
  <Video src={staticFile("video.mp4")} />
</Sequence>
```

## Volume

```tsx
<Video src={staticFile("video.mp4")} volume={0.5} />
<Video src={staticFile("video.mp4")} volume={(f) =>
  interpolate(f, [0, 1 * fps], [0, 1], { extrapolateRight: "clamp" })
} />
<Video src={staticFile("video.mp4")} muted />
```

## Speed & Looping

```tsx
<Video src={staticFile("video.mp4")} playbackRate={2} />
<Video src={staticFile("video.mp4")} loop />
```

## Pitch

`toneFrequency` (0.01–2): only works during server-side rendering.

```tsx
<Video src={staticFile("video.mp4")} toneFrequency={1.5} />
```
