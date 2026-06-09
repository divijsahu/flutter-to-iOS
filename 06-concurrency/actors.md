# Actors & @MainActor

> Actors are Swift's answer to Dart's Isolates — isolated concurrent state. Unlike Isolates, actors share memory but enforce mutual exclusion at compile time.

## @MainActor — Keep UI on Main Thread

```dart
// Flutter — WidgetsBinding for main thread
WidgetsBinding.instance.addPostFrameCallback((_) {
  setState(() { /* UI update */ });
});
```

```swift
// Swift — @MainActor annotation
@Observable @MainActor
class ViewModel {
  var items: [Item] = []        // all UI updates guaranteed on main thread

  func loadItems() async {
    let fetched = try? await fetchFromAPI()
    items = fetched ?? []       // already on main — safe!
  }
}

// Or call explicitly
await MainActor.run {
  self.items = newItems
}
```

## Custom Actors

```swift
// Actor — like Isolate but with shared memory access
actor DataCache {
  private var cache: [String: Data] = [:]

  func get(_ key: String) -> Data? {
    cache[key]
  }

  func set(_ key: String, value: Data) {
    cache[key] = value           // Swift guarantees no data races
  }
}

// Usage — must await calls to actor methods
let cache = DataCache()
await cache.set("user_1", value: userData)
let data = await cache.get("user_1")
```

## Structured Concurrency

```swift
// Task — creates concurrent work
Task {                          // unstructured task
  await heavyWork()
}

Task.detached {                 // fully independent task (no actor context)
  await backgroundWork()
}

// Cancellation — cooperative
func loadData() async {
  for chunk in dataChunks {
    try Task.checkCancellation()  // throws if cancelled
    await process(chunk)
  }
}

// In SwiftUI — .task cancels automatically
.task(id: searchQuery) {        // re-runs when searchQuery changes, cancels previous
  results = await search(searchQuery)
}
```

## Task Groups — Dynamic Parallelism

```swift
let results = try await withThrowingTaskGroup(of: ProcessedItem.self) { group in
  for item in items {
    group.addTask { try await process(item) }
  }
  var processed: [ProcessedItem] = []
  for try await result in group {
    processed.append(result)
  }
  return processed
}
```
