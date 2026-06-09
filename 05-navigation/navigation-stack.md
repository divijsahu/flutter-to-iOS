# NavigationStack

## Basic Push Navigation

```dart
// Flutter — Navigator
Navigator.of(context).push(
  MaterialPageRoute(builder: (_) => DetailScreen(item: item)),
);
Navigator.of(context).pop();
```

```swift
// SwiftUI — NavigationStack + NavigationLink
NavigationStack {
  List(items) { item in
    NavigationLink(value: item) {          // pass typed value, not a view
      ItemRow(item: item)
    }
  }
  .navigationTitle("Items")
  .navigationDestination(for: Item.self) { item in   // handles all Item pushes
    DetailView(item: item)
  }
}
```

## Programmatic Navigation

```dart
// Flutter / GoRouter
context.go('/detail/${item.id}');
context.pop();
```

```swift
// SwiftUI — NavigationStack with path
struct ContentView: View {
  @State private var path: [Item] = []     // navigation stack as array

  var body: some View {
    NavigationStack(path: $path) {
      ItemListView()
        .navigationDestination(for: Item.self) { DetailView(item: $0) }
    }
  }
}

// Push programmatically
path.append(selectedItem)

// Pop
path.removeLast()

// Pop to root
path.removeAll()
```

## Multiple Destination Types

```swift
// Swift enums work great here
enum AppRoute: Hashable {
  case detail(Item)
  case profile(User)
  case settings
}

NavigationStack(path: $path) {
  HomeView()
    .navigationDestination(for: AppRoute.self) { route in
      switch route {
      case .detail(let item): DetailView(item: item)
      case .profile(let user): ProfileView(user: user)
      case .settings: SettingsView()
      }
    }
}
```

## Back Button and Navigation Bar

```swift
struct DetailView: View {
  var item: Item
  @Environment(\.dismiss) var dismiss

  var body: some View {
    ScrollView {
      Text(item.description)
    }
    .navigationTitle(item.name)
    .navigationBarTitleDisplayMode(.inline)   // .large (default) or .inline
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button("Share") { shareItem() }
      }
    }
    // Custom back button:
    .navigationBarBackButtonHidden()
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        Button { dismiss() } label: {
          Label("Back", systemImage: "chevron.left")
        }
      }
    }
  }
}
```
