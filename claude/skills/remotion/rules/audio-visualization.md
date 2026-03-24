---
name: audio-visualization
description: Audio visualization - spectrum bars, waveforms, bass-reactive effects
---

## Prerequisites

```bash
npx remotion add @remotion/media-utils
```

## Loading audio data

```tsx
import { useWindowedAudioData } from "@remotion/media-utils";

const { audioData, dataOffsetInSeconds } = useWindowedAudioData({
  src: staticFile("podcast.wav"),
  frame,
  fps,
  windowInSeconds: 30,
});
```

## Spectrum bars

```tsx
import { visualizeAudio } from "@remotion/media-utils";

const frequencies = visualizeAudio({
  fps, frame, audioData, numberOfSamples: 256, optimizeFor: "speed", dataOffsetInSeconds,
});

// frequencies: 0-1 array, left = bass, right = highs
// numberOfSamples must be power of 2
```

**Important:** When passing `audioData` to children, also pass `frame` from parent. Do not call `useCurrentFrame()` in each child inside offset `<Sequence>`.

## Waveform

```tsx
import { visualizeAudioWaveform, createSmoothSvgPath } from "@remotion/media-utils";

const waveform = visualizeAudioWaveform({
  fps, frame, audioData, numberOfSamples: 256, windowInSeconds: 0.5, dataOffsetInSeconds,
});

const path = createSmoothSvgPath({
  points: waveform.map((y, i) => ({ x: (i / (waveform.length - 1)) * width, y: HEIGHT / 2 + (y * HEIGHT) / 2 })),
});

<svg><path d={path} fill="none" stroke="#0b84f3" strokeWidth={2} /></svg>
```

## Bass-reactive

```tsx
const lowFrequencies = frequencies.slice(0, 32);
const bassIntensity = lowFrequencies.reduce((s, v) => s + v, 0) / lowFrequencies.length;
const scale = 1 + bassIntensity * 0.5;
```

## Postprocessing (logarithmic scaling)

```tsx
const minDb = -100, maxDb = -30;
const scaled = frequencies.map(v => {
  const db = 20 * Math.log10(v);
  return (db - minDb) / (maxDb - minDb);
});
```
