---
name: calculate-metadata
description: Dynamically set composition duration, dimensions, and props
---

## Usage

```tsx
<Composition
  id="MyComp"
  component={MyComponent}
  durationInFrames={300}
  fps={30}
  width={1920}
  height={1080}
  defaultProps={{ videoSrc: "https://remotion.media/video.mp4" }}
  calculateMetadata={calculateMetadata}
/>
```

## Setting duration from video

```tsx
import { CalculateMetadataFunction } from "remotion";

const calculateMetadata: CalculateMetadataFunction<Props> = async ({ props }) => {
  const durationInSeconds = await getVideoDuration(props.videoSrc);
  return { durationInFrames: Math.ceil(durationInSeconds * 30) };
};
```

## Transforming props

```tsx
const calculateMetadata: CalculateMetadataFunction<Props> = async ({ props, abortSignal }) => {
  const data = await fetch(props.dataUrl, { signal: abortSignal }).then(r => r.json());
  return { props: { ...props, fetchedData: data } };
};
```

`abortSignal` cancels stale requests when props change in Studio.

## Return value (all optional)

`durationInFrames`, `width`, `height`, `fps`, `props`, `defaultOutName`, `defaultCodec`
