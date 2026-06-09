<div align="center">

# 🍎 flutter-to-ios

**Flutter and SwiftUI are the same mental model. Different vocabulary.**
**This repo is the translation dictionary.**

[![Stars](https://img.shields.io/github/stars/divijsahu/flutter-to-ios?style=flat-square&color=FA7343&labelColor=0d0d14&logo=github&label=stars)](https://github.com/divijsahu/flutter-to-ios/stargazers)
[![Forks](https://img.shields.io/github/forks/divijsahu/flutter-to-ios?style=flat-square&color=54C5F8&labelColor=0d0d14&logo=github&label=forks)](https://github.com/divijsahu/flutter-to-ios/forks)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-FA7343.svg?style=flat-square&labelColor=0d0d14)](CONTRIBUTING.md)
[![Swift](https://img.shields.io/badge/Swift-6.2-FA7343.svg?style=flat-square&labelColor=0d0d14&logo=swift&logoColor=FA7343)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-26-0A84FF.svg?style=flat-square&labelColor=0d0d14&logo=xcode&logoColor=0A84FF)](https://developer.apple.com/xcode/)
[![iOS](https://img.shields.io/badge/iOS-26-0A84FF.svg?style=flat-square&labelColor=0d0d14&logo=apple&logoColor=white)](https://developer.apple.com/ios/)
[![Flutter](https://img.shields.io/badge/Flutter-3.x-54C5F8.svg?style=flat-square&labelColor=0d0d14&logo=flutter&logoColor=54C5F8)](https://flutter.dev)

</div>

---

## 🖥 Live Visual Cheatsheet

👉 **[Open Interactive Cheatsheet](https://divijsahu.github.io/flutter-to-ios/cheatsheet.html)**

> Side-by-side Dart/Flutter vs Swift/SwiftUI with diagrams, concept maps, and syntax highlighting. Works offline. No frameworks.

---

## The mental model shift

I wasted 3 months searching "how does setState work in Swift." Turns out — it's `@State`. Same idea. Different word.

Flutter and SwiftUI share the same reactive, declarative, component-based mental model. The vocabulary is just different. Once you see the mapping, iOS dev clicks immediately.

---

## 🗺 Complete Concept Map

| Flutter / Dart | Swift / SwiftUI | Notes |
|---|---|---|
| **CORE** | | |
| `Widget` | `View` | The fundamental UI building block |
| `StatelessWidget` | `struct : View` | Pure rendering, no mutable state |
| `StatefulWidget` | `struct : View + @State` | View with local mutable state |
| `setState(() {})` | mutate `@State` directly | Auto-triggers re-render, no call needed |
| `build(BuildContext)` | `var body: some View` | Returns the UI tree |
| `const Widget()` | *(struct is already value type)* | SwiftUI structs are lightweight by default |
| `key:` parameter | `id:` in ForEach / `Identifiable` | Stable identity for list diffing |
| **STATE** | | |
| `StatefulWidget + setState` | `@State` | Local, private, simple values |
| Callback / `onChanged:` | `@Binding` | Two-way state passed from parent |
| `ChangeNotifier` | `@Observable class` | Shared mutable model object |
| `notifyListeners()` | *(automatic)* | `@Observable` tracks access, no manual call |
| `Provider.of<T>(context)` | pass model directly / `@Environment` | Dependency injection |
| `InheritedWidget` | `@Environment` | Propagate values down the tree |
| `ValueNotifier<T>` | `@State var value: T` | Simple observable value |
| `FutureBuilder<T>` | `.task { }` modifier | Async UI with loading/error states |
| `StreamBuilder<T>` | `.task { } + AsyncStream` | Reactive stream UI |
| `SharedPreferences` | `@AppStorage` | Persistent key-value storage |
| **LAYOUT** | | |
| `Column()` | `VStack { }` | Vertical stack |
| `Row()` | `HStack { }` | Horizontal stack |
| `Stack()` | `ZStack { }` | Overlapping / layered views |
| `Spacer()` | `Spacer()` | Flexible expanding space |
| `Padding(all: 16)` | `.padding(16)` | Edge insets |
| `SizedBox(w, h)` | `.frame(width:height:)` | Fixed dimensions |
| `Expanded()` | `.frame(maxWidth: .infinity)` | Fill available axis space |
| `Center()` | `.frame(maxWidth: .infinity, maxHeight: .infinity)` | Center in available space |
| `Wrap()` | `FlowLayout` / `ViewThatFits` | Wrapping / flowing layout |
| `SafeArea()` | default safe area + `.ignoresSafeArea()` | System UI avoidance |
| **COMPONENTS** | | |
| `Text("hi")` | `Text("hi")` | Text label |
| `Icon(Icons.star)` | `Image(systemName: "star")` | System icon (SF Symbols) |
| `Image.asset("img")` | `Image("img")` | Asset image |
| `Image.network(url)` | `AsyncImage(url: url)` | Network image with loading |
| `Container()` | `Rectangle()` + modifiers | Box / decorated container |
| `Card()` | `RoundedRectangle()` + `.shadow()` | Card appearance |
| `Divider()` | `Divider()` | Horizontal separator |
| `CircularProgressIndicator()` | `ProgressView()` | Loading spinner |
| `LinearProgressIndicator()` | `ProgressView(value:)` | Progress bar |
| **INTERACTIVE** | | |
| `ElevatedButton()` | `Button().buttonStyle(.borderedProminent)` | Primary filled button |
| `TextButton()` | `Button()` (default style) | Text-only button |
| `TextField()` | `TextField("placeholder", text: $x)` | Text input field |
| `Switch(value: x)` | `Toggle("label", isOn: $x)` | On/off toggle |
| `Slider(value: x)` | `Slider(value: $x, in: 0...100)` | Continuous range slider |
| `DropdownButton()` | `Picker("label", selection: $x)` | Selection picker |
| `GestureDetector()` | `.onTapGesture { }` / `.gesture()` | Touch / gesture handling |
| **NAVIGATION** | | |
| `Navigator.push()` | `NavigationLink(value:)` | Push a screen |
| `Navigator.pop()` | `dismiss()` via `@Environment` | Dismiss / pop back |
| `GoRouter` | `NavigationStack` | Declarative router |
| `BottomNavigationBar` | `TabView + .tabItem { }` | Tab bar navigation |
| `showDialog()` | `.alert("title", isPresented: $x)` | Alert dialog |
| `showModalBottomSheet()` | `.sheet(isPresented: $x)` | Modal bottom sheet |
| **ARCHITECTURE** | | |
| `abstract class` | `protocol` | Interface / contract |
| `mixin` | `protocol extension` | Default implementation |
| `extension methods` | `extension` | Extend existing types |
| `sealed class` | `enum` with associated values | Exhaustive sum type |
| `factory constructor` | `static func` | Factory pattern |
| **PERSISTENCE** | | |
| `shared_preferences` | `@AppStorage` | Simple key-value |
| `sqflite` / `Hive` | `SwiftData` | Structured local database |
| `path_provider` | `FileManager` | File system access |
| **TOOLING** | | |
| `pubspec.yaml` | `Package.swift` | Dependency manifest |
| `pub.dev` | Swift Package Index | Package registry |
| `flutter run` | `Cmd + R` in Xcode | Run on simulator/device |
| `flutter test` | Xcode Test target | Unit & UI tests |
| `DartDoc` | `DocC` | Documentation generator |

---

## 📚 Sections

| # | Section | What's inside |
|---|---|---|
| 01 | [Concept Map](./01-concept-map/) | Full 50+ mapping table with emoji categories |
| 02 | [Language Basics](./02-language/) | Variables, functions, optionals, collections, error handling, enums |
| 03 | [Views & Layout](./03-views-layout/) | Your first view, stacks, modifiers, lists |
| 04 | [State Management](./04-state/) | 8 property wrappers, @Observable, data flow diagram |
| 05 | [Navigation](./05-navigation/) | NavigationStack, tabs, sheets, alerts |
| 06 | [Concurrency](./06-concurrency/) | async/await, actors, async let parallelism |
| 07 | [Architecture](./07-architecture/) | MVVM pattern, SwiftData |
| 08 | [Liquid Glass](./08-liquid-glass/) | iOS 26's design shift — why Flutter devs should care |
| 09 | [Components](./09-components/) | Full widget-to-view reference table |
| 10 | [Projects](./10-projects/) | Todo app + Profile screen with Flutter equivalents |

---

## Who is this for?

- Flutter developers starting iOS development
- Dart developers learning Swift
- Anyone who thinks iOS dev "feels different" — it doesn't, you just need the vocabulary

---

## Quick start

```bash
git clone https://github.com/divijsahu/flutter-to-ios
cd flutter-to-ios
open cheatsheet.html        # macOS
# or: xdg-open cheatsheet.html on Linux
# or just drag the .html file into any browser
```

No build step. No dependencies. Open the HTML, bookmark it, use it.

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). PRs welcome for:
- New concept mappings
- Better code examples
- Corrections to any Swift/Dart code
- Additional project examples

---

## License

MIT — use it, share it, fork it. If it saves you time, [drop a ⭐](https://github.com/divijsahu/flutter-to-ios) — it helps other Flutter devs find it.
