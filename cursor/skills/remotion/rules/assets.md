---
name: assets
description: Importing images, videos, audio, and fonts into Remotion
---

## The public folder

Place assets in `public/` at project root.

## staticFile()

MUST use `staticFile()` to reference `public/` files:

```tsx
import { Img, staticFile } from "remotion";
<Img src={staticFile("logo.png")} />
```

```tsx
import { Video } from "@remotion/media";
<Video src={staticFile("clip.mp4")} />
```

```tsx
import { Audio } from "@remotion/media";
<Audio src={staticFile("music.mp3")} />
```

## Remote URLs

Use directly without `staticFile()`:

```tsx
<Img src="https://example.com/image.png" />
```

Remotion components (`<Img>`, `<Video>`, `<Audio>`) ensure assets are fully loaded before rendering.
