---
name: fonts
description: Loading Google Fonts and local fonts in Remotion
---

## Google Fonts

```bash
npx remotion add @remotion/google-fonts
```

```tsx
import { loadFont } from "@remotion/google-fonts/Lobster";
const { fontFamily } = loadFont();

<div style={{ fontFamily }}>Hello World</div>
```

Specify weights/subsets to reduce size:

```tsx
const { fontFamily } = loadFont("normal", { weights: ["400", "700"], subsets: ["latin"] });
```

## Local fonts

```bash
npx remotion add @remotion/fonts
```

```tsx
import { loadFont } from "@remotion/fonts";
import { staticFile } from "remotion";

await loadFont({ family: "MyFont", url: staticFile("MyFont-Regular.woff2") });
```

Multiple weights:

```tsx
await Promise.all([
  loadFont({ family: "Inter", url: staticFile("Inter-Regular.woff2"), weight: "400" }),
  loadFont({ family: "Inter", url: staticFile("Inter-Bold.woff2"), weight: "700" }),
]);
```
