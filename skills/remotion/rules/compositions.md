---
name: compositions
description: Defining compositions, stills, folders, default props and dynamic metadata
---

## Composition

Placed in `src/Root.tsx`:

```tsx
import { Composition } from "remotion";
import { MyComposition } from "./MyComposition";

export const RemotionRoot = () => (
  <Composition
    id="MyComposition"
    component={MyComposition}
    durationInFrames={100}
    fps={30}
    width={1080}
    height={1080}
  />
);
```

## Default Props

Use `type` (not `interface`) for props. Values must be JSON-serializable.

```tsx
<Composition
  id="MyComposition"
  component={MyComposition}
  durationInFrames={100}
  fps={30}
  width={1080}
  height={1080}
  defaultProps={{ title: "Hello World", color: "#ff0000" } satisfies MyCompositionProps}
/>
```

## Folders

```tsx
<Folder name="Marketing">
  <Composition id="Promo" /* ... */ />
</Folder>
```

## Stills

No `durationInFrames` or `fps` required:

```tsx
<Still id="Thumbnail" component={Thumbnail} width={1280} height={720} />
```

## calculateMetadata

See [calculate-metadata.md](calculate-metadata.md) for dynamic duration/dimensions.
