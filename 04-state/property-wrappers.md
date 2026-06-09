# Property Wrappers

SwiftUI uses property wrappers to tell the framework *what kind of state* each variable is. The `@` prefix is the signal.

## @State — Local, Private

```dart
// Flutter
class Counter extends StatefulWidget {
  @override
  State<Counter> createState() => _CounterState();
}
class _CounterState extends State<Counter> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('$count'),
      ElevatedButton(
        onPressed: () => setState(() => count++),
        child: const Text('Increment'),
      ),
    ]);
  }
}
```

```swift
// SwiftUI
struct Counter: View {
  @State private var count = 0    // @State = managed by SwiftUI, triggers re-render

  var body: some View {
    VStack {
      Text("\(count)")
      Button("Increment") {
        count += 1                 // just assign — no setState needed
      }
    }
  }
}
```

**Rules for @State:**
- Always `private`
- Simple value types: `Bool`, `Int`, `String`, `[T]`
- Lives inside the view struct — don't pass it to parent
- For complex shared models, use `@Observable` instead

---

## @Binding — Two-Way Reference

```dart
// Flutter — manual callback + value
class ToggleRow extends StatelessWidget {
  final String label;
  final bool isOn;
  final ValueChanged<bool> onChanged;
  const ToggleRow({required this.label, required this.isOn, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(label),
      Switch(value: isOn, onChanged: onChanged),
    ]);
  }
}
// Usage:
ToggleRow(label: 'Dark Mode', isOn: isDark, onChanged: (val) => setState(() => isDark = val))
```

```swift
// SwiftUI — @Binding creates a two-way reference
struct ToggleRow: View {
  let label: String
  @Binding var isOn: Bool       // reads AND writes back to parent's @State

  var body: some View {
    Toggle(label, isOn: $isOn)  // $ prefix creates a Binding from the @Binding
  }
}

// Usage in parent:
struct ParentView: View {
  @State private var isDark = false

  var body: some View {
    ToggleRow(label: "Dark Mode", isOn: $isDark)  // $ creates Binding<Bool>
  }
}
```

---

## @Observable — Shared Model (iOS 17+, preferred in Xcode 26)

See [observable-pattern.md](observable-pattern.md) for the full comparison.

```swift
@Observable
class CartModel {
  var items: [CartItem] = []
  var total: Double { items.reduce(0) { $0 + $1.price } }

  func add(_ item: CartItem) { items.append(item) }
  func remove(at offsets: IndexSet) { items.remove(atOffsets: offsets) }
}
```

---

## @Environment — System & Injected Values

```swift
struct ContentView: View {
  @Environment(\.colorScheme) var colorScheme
  @Environment(\.dismiss) var dismiss
  @Environment(\.locale) var locale
  @Environment(\.horizontalSizeClass) var sizeClass
  @Environment(\.openURL) var openURL

  var body: some View {
    VStack {
      Text(colorScheme == .dark ? "Dark Mode" : "Light Mode")
      Button("Open Apple") { openURL(URL(string: "https://apple.com")!) }
      Button("Dismiss") { dismiss() }
    }
  }
}

// Inject custom model via environment
struct App: App {
  let cart = CartModel()

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(cart)        // inject into view hierarchy
    }
  }
}

// Read it anywhere below
struct CartBadge: View {
  @Environment(CartModel.self) var cart   // read the injected model

  var body: some View {
    Text("\(cart.items.count)")
  }
}
```

---

## @AppStorage — Persistent Key-Value

```dart
// Flutter
import 'package:shared_preferences/shared_preferences.dart';

final prefs = await SharedPreferences.getInstance();
prefs.setBool('darkMode', true);
final isDark = prefs.getBool('darkMode') ?? false;
```

```swift
// SwiftUI — one line, no async, auto-persists to UserDefaults
struct SettingsView: View {
  @AppStorage("darkMode") private var darkMode = false
  @AppStorage("userName") private var userName = ""
  @AppStorage("fontSize") private var fontSize = 16.0

  var body: some View {
    Form {
      Toggle("Dark Mode", isOn: $darkMode)
      TextField("Name", text: $userName)
      Slider(value: $fontSize, in: 12...24, label: { Text("Font Size") })
    }
  }
}
// Changes write through to UserDefaults automatically. No save() call.
```

---

## Quick Reference

| Wrapper | Flutter equivalent | Use for |
|---|---|---|
| `@State` | `setState` | Local, private, single-view state |
| `@Binding` | callback + value param | Two-way state passed from parent |
| `@Observable` | `ChangeNotifier` | Shared mutable model |
| `@Environment` | `InheritedWidget` / Provider | System values and injected models |
| `@AppStorage` | `shared_preferences` | Persisted key-value (UserDefaults) |
| `@FocusState` | `FocusNode` | Keyboard focus management |
| `@GestureState` | gesture tracking | Transient gesture state |
| `@SceneStorage` | — | Per-scene UI state (restored on relaunch) |
