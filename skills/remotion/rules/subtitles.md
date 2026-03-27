---
name: subtitles
description: Subtitles and caption rules
---

All captions must use the `Caption` type from `@remotion/captions`:

```ts
import type { Caption } from "@remotion/captions";

type Caption = {
  text: string;
  startMs: number;
  endMs: number;
  timestampMs: number | null;
  confidence: number | null;
};
```

Captions are processed in JSON format.

## Workflows

- **Generating captions**: Transcribe video/audio to generate captions
- **Displaying captions**: Render captions synced to the video timeline
- **Importing captions**: Parse `.srt` files into `Caption[]`

For detailed instructions on each workflow, refer to the Remotion captions documentation at https://www.remotion.dev/docs/captions
