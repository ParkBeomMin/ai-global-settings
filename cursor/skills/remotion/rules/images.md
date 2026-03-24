---
name: images
description: Embedding images in Remotion using the Img component
---

MUST use `<Img>` from `remotion`. Never use native `<img>`, Next.js `<Image>`, or CSS `background-image`.

```tsx
import { Img, staticFile } from "remotion";
<Img src={staticFile("photo.png")} />
```

## Sizing

```tsx
<Img src={staticFile("photo.png")} style={{ width: 500, height: 300, objectFit: "cover" }} />
```

## Dynamic paths

```tsx
<Img src={staticFile(`frames/frame${frame}.png`)} />
<Img src={staticFile(`avatars/${props.userId}.png`)} />
```

## Getting dimensions

```tsx
import { getImageDimensions, staticFile } from "remotion";
const { width, height } = await getImageDimensions(staticFile("photo.png"));
```
