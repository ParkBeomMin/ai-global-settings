---
name: parameters
description: Make a video parametrizable by adding a Zod schema
---

## Setup

Install `zod` with your package manager. Then define a schema:

```tsx
import { z } from "zod";

export const MyCompositionSchema = z.object({
  title: z.string(),
});

const MyComponent: React.FC<z.infer<typeof MyCompositionSchema>> = (props) => (
  <div><h1>{props.title}</h1></div>
);
```

Pass schema to the composition:

```tsx
<Composition
  id="MyComposition"
  component={MyComponent}
  durationInFrames={100}
  fps={30}
  width={1080}
  height={1080}
  defaultProps={{ title: "Hello World" }}
  schema={MyCompositionSchema}
/>
```

Top-level type must be `z.object()`.

## Color picker

```bash
npx remotion add @remotion/zod-types
```

```tsx
import { zColor } from "@remotion/zod-types";

export const Schema = z.object({ color: zColor() });
```
