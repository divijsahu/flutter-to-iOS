# Stacks: VStack / HStack / ZStack

## VStack — Vertical (Flutter's Column)

```dart
// Flutter Column
Column(
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.center,
  mainAxisSize: MainAxisSize.min,
  children: [
    Text('Title'),
    const SizedBox(height: 8),
    Text('Subtitle'),
    const SizedBox(height: 16),
    ElevatedButton(onPressed: () {}, child: Text('Action')),
  ],
)
```

```swift
// SwiftUI VStack
VStack(alignment: .center, spacing: 8) {
  Text("Title")
  Text("Subtitle")             // spacing handled by stack parameter
  Spacer().frame(height: 8)    // or add extra spacing with frame
  Button("Action") { }
}
```

## HStack — Horizontal (Flutter's Row)

```dart
// Flutter Row
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Icon(Icons.star, color: Colors.amber),
    Text('Rating'),
    const Spacer(),
    Text('4.9'),
  ],
)
```

```swift
// SwiftUI HStack
HStack {
  Image(systemName: "star.fill")
    .foregroundStyle(.yellow)
  Text("Rating")
  Spacer()
  Text("4.9")
}
```

## ZStack — Overlapping (Flutter's Stack)

```dart
// Flutter Stack
Stack(
  alignment: Alignment.bottomRight,
  children: [
    Image.network('https://...'),
    Positioned(
      bottom: 8, right: 8,
      child: Badge(label: Text('New')),
    ),
  ],
)
```

```swift
// SwiftUI ZStack
ZStack(alignment: .bottomTrailing) {
  AsyncImage(url: url)
  Text("New")
    .padding(6)
    .background(.red)
    .clipShape(Capsule())
    .padding(8)               // inner padding from the corner
}
```

## Alignment Quick Reference

| Flutter `CrossAxisAlignment` | SwiftUI `VStack alignment:` |
|---|---|
| `.start` | `.leading` |
| `.center` | `.center` |
| `.end` | `.trailing` |
| `.stretch` | `.frame(maxWidth: .infinity)` on children |

| Flutter `MainAxisAlignment` | SwiftUI equivalent |
|---|---|
| `.start` | default |
| `.center` | wrap in another centered frame |
| `.end` | `Spacer()` at top |
| `.spaceBetween` | `Spacer()` between items |
| `.spaceAround` | `Spacer()` + padding |

## Lazy Stacks (Performance)

```swift
// Use for large, dynamic content — only renders visible items
ScrollView {
  LazyVStack(spacing: 12, pinnedViews: .sectionHeaders) {
    Section {
      ForEach(items) { item in
        ItemRow(item: item)
      }
    } header: {
      Text("Items").font(.headline).padding()
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
    }
  }
}
```
