# Tabs & Sheets

## TabView

```dart
// Flutter — BottomNavigationBar + IndexedStack
class MainScreen extends StatefulWidget { ... }
class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final _pages = [HomeScreen(), SearchScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
```

```swift
// SwiftUI — TabView (Liquid Glass on iOS 26 automatically)
TabView {
  Tab("Home", systemImage: "house.fill") {
    HomeView()
  }
  Tab("Search", systemImage: "magnifyingglass") {
    SearchView()
  }
  Tab("Profile", systemImage: "person.fill") {
    ProfileView()
  }
}
// That's it. iOS 26 gives you Liquid Glass tab bar for free.
```

## Sheets (Modal Bottom Sheets)

```dart
// Flutter
showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
  builder: (_) => const FilterSheet(),
);
```

```swift
// SwiftUI
struct ContentView: View {
  @State private var showFilter = false

  var body: some View {
    Button("Filter") { showFilter = true }
      .sheet(isPresented: $showFilter) {
        FilterSheet()
          .presentationDetents([.medium, .large])    // half-height or full
          .presentationDragIndicator(.visible)
      }
  }
}
```

## Alerts

```dart
// Flutter
showDialog(
  context: context,
  builder: (_) => AlertDialog(
    title: const Text('Delete?'),
    content: const Text('This cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
      TextButton(onPressed: () { delete(); Navigator.pop(context); }, child: const Text('Delete')),
    ],
  ),
);
```

```swift
// SwiftUI
struct ContentView: View {
  @State private var showDeleteAlert = false

  var body: some View {
    Button("Delete", role: .destructive) { showDeleteAlert = true }
      .alert("Delete Item?", isPresented: $showDeleteAlert) {
        Button("Delete", role: .destructive) { deleteItem() }
        Button("Cancel", role: .cancel) { }
      } message: {
        Text("This cannot be undone.")
      }
  }
}
```

## Full-Screen Cover

```dart
// Flutter
Navigator.push(context, PageRouteBuilder(
  pageBuilder: (_, __, ___) => const OnboardingScreen(),
  transitionsBuilder: ...,
));
```

```swift
// SwiftUI
.fullScreenCover(isPresented: $showOnboarding) {
  OnboardingView()
}
```
