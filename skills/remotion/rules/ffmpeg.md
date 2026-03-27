---
name: ffmpeg
description: Using FFmpeg and FFprobe in Remotion
---

`ffmpeg` and `ffprobe` are available via Remotion CLI — no separate install needed:

```bash
bunx remotion ffmpeg -i input.mp4 output.mp3
bunx remotion ffprobe input.mp4
```

## Trimming videos

Option 1: FFmpeg CLI (MUST re-encode to avoid frozen frames):

```bash
bunx remotion ffmpeg -ss 00:00:05 -i public/input.mp4 -to 00:00:10 -c:v libx264 -c:a aac public/output.mp4
```

Option 2: Non-destructive via `<Video>` props:

```tsx
import { Video } from "@remotion/media";
<Video src={staticFile("video.mp4")} trimBefore={5 * fps} trimAfter={10 * fps} />
```
