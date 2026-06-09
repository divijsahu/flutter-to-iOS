# 🖼 Views & Layout

| File | Topic |
|---|---|
| [your-first-view.md](your-first-view.md) | Anatomy of a SwiftUI view vs Flutter widget |
| [stacks.md](stacks.md) | VStack / HStack / ZStack — Column / Row / Stack |
| [modifiers.md](modifiers.md) | Chaining vs wrapping — the #1 mindset shift |
| [lists-foreach.md](lists-foreach.md) | List, ForEach, LazyVStack |

> **The single biggest shift:** Flutter wraps widgets for decoration. SwiftUI chains modifiers. `Padding(child: Container(color: ..., child: Text()))` becomes `Text().padding().background()`. Order still matters — read [modifiers.md](modifiers.md).
