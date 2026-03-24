---
name: remotion-best-practices
description: Best practices for building videos with Remotion and React. Use when writing Remotion code, creating video compositions, handling animations, audio, transitions, subtitles, or any React-based video generation task.
---

# Remotion Best Practices

## When to use

Use this skill whenever dealing with Remotion code to obtain domain-specific knowledge.

## Critical Rules

- All animations MUST use `useCurrentFrame()` — CSS transitions/animations and Tailwind animate classes are FORBIDDEN
- Always use `<Img>` from `remotion`, never native `<img>` or CSS `background-image`
- Use `staticFile()` for all `public/` folder assets
- Use `type` (not `interface`) for component props to ensure `defaultProps` type safety
- Always premount `<Sequence>` components that contain `<Video>`
- TailwindCSS `transition-*` and `animate-*` classes must NOT be used

## Captions & Subtitles

When dealing with captions or subtitles, load [./rules/subtitles.md](./rules/subtitles.md).

## FFmpeg

For video operations like trimming or silence detection, load [./rules/ffmpeg.md](./rules/ffmpeg.md).

## Audio Visualization

For spectrum bars, waveforms, or bass-reactive effects, load [./rules/audio-visualization.md](./rules/audio-visualization.md).

## Rule Files

Read individual rule files for detailed explanations and code examples:

| File | Topic |
|------|-------|
| [rules/animations.md](rules/animations.md) | Fundamental animations (`useCurrentFrame`, `interpolate`) |
| [rules/timing.md](rules/timing.md) | Interpolation curves — linear, easing, spring |
| [rules/sequencing.md](rules/sequencing.md) | `<Sequence>`, `<Series>`, delay, trim, nested timing |
| [rules/trimming.md](rules/trimming.md) | Trim start/end of animations |
| [rules/transitions.md](rules/transitions.md) | `<TransitionSeries>`, fade, slide, wipe, overlays |
| [rules/compositions.md](rules/compositions.md) | `<Composition>`, `<Still>`, `<Folder>`, `calculateMetadata` |
| [rules/calculate-metadata.md](rules/calculate-metadata.md) | Dynamic duration, dimensions, props |
| [rules/parameters.md](rules/parameters.md) | Zod schema for parametrizable videos |
| [rules/assets.md](rules/assets.md) | Importing images, videos, audio, fonts via `staticFile()` |
| [rules/images.md](rules/images.md) | `<Img>` component, sizing, dynamic paths |
| [rules/videos.md](rules/videos.md) | `<Video>` — trimming, volume, speed, looping, pitch |
| [rules/audio.md](rules/audio.md) | `<Audio>` — importing, trimming, volume, speed, pitch |
| [rules/fonts.md](rules/fonts.md) | Google Fonts and local fonts |
| [rules/text-animations.md](rules/text-animations.md) | Typewriter, word highlight effects |
| [rules/tailwind.md](rules/tailwind.md) | TailwindCSS integration |
| [rules/subtitles.md](rules/subtitles.md) | Caption types and processing |
| [rules/audio-visualization.md](rules/audio-visualization.md) | Spectrum bars, waveforms, bass-reactive |
| [rules/ffmpeg.md](rules/ffmpeg.md) | FFmpeg/FFprobe via `bunx remotion ffmpeg` |
