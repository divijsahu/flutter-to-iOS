# 🗺️ Flutter → SwiftUI Concept Map

> The complete vocabulary translation. Every Flutter concept and its SwiftUI equivalent, grouped by category.

---

## 🧱 Core

| Flutter | SwiftUI | Notes |
|---|---|---|
| `Widget` | `View` | Everything is a View/Widget — the atomic unit |
| `StatelessWidget` | `struct : View` | Pure rendering, computed from inputs |
| `StatefulWidget` | `struct : View` with `@State` | View that owns mutable local state |
| `setState(() {})` | mutate `@State` directly | Just assign — SwiftUI sees it, re-renders |
| `build(BuildContext context)` | `var body: some View` | Returns the view tree |
| `context` | *(implicit via `@Environment`)* | No context passed — environment is implicit |
| `key:` | `id:` / `Identifiable` | Stable identity for diffing |

---

## 🔄 State Management

| Flutter | SwiftUI | Notes |
|---|---|---|
| `StatefulWidget + setState` | `@State` | Local, private, value-type state |
| `onChanged: (val) =>` callback | `@Binding` | Two-way mutable reference from parent |
| `ChangeNotifier + notifyListeners()` | `@Observable class` | Shared model — auto-tracks, no manual notify |
| `Provider.of<T>(context)` | pass model / `@Environment` | Inject shared model |
| `InheritedWidget` | `@Environment(\.key)` | Propagate values down the tree implicitly |
| `ValueNotifier<T>` | `@State var x: T` | Simple observable scalar |
| `FutureBuilder<T>` | `.task { }` modifier | Async loading with auto-cancel on disappear |
| `StreamBuilder<T>` | `.task { } + AsyncStream` | Reactive stream binding |
| `SharedPreferences` | `@AppStorage("key")` | Persistent key-value (UserDefaults backed) |

---

## 📐 Layout

| Flutter | SwiftUI | Notes |
|---|---|---|
| `Column()` | `VStack { }` | Vertical — top to bottom |
| `Row()` | `HStack { }` | Horizontal — left to right |
| `Stack()` | `ZStack { }` | Depth — back to front |
| `Spacer()` | `Spacer()` | Pushes siblings to edges |
| `SizedBox(width: x, height: y)` | `.frame(width: x, height: y)` | Fixed size |
| `Expanded(child: w)` | `.frame(maxWidth: .infinity)` | Fill remaining space on axis |
| `Padding(EdgeInsets.all(16))` | `.padding(16)` | Inset content |
| `Center(child: w)` | `.frame(maxWidth: .infinity, maxHeight: .infinity)` | Center in parent |
| `Wrap()` | `FlowLayout` / `ViewThatFits` | Wrap content to next line |
| `SafeArea(child: w)` | *(default)* + `.ignoresSafeArea()` | Handled automatically by default |
| `AspectRatio(16/9)` | `.aspectRatio(16/9, contentMode: .fit)` | Fixed aspect ratio |
| `FractionallySizedBox` | `.containerRelativeFrame(.horizontal)` | Size relative to parent |

---

## 🖼 Common Views

| Flutter | SwiftUI | Notes |
|---|---|---|
| `Text("hello")` | `Text("hello")` | Text label |
| `Icon(Icons.star)` | `Image(systemName: "star")` | SF Symbols — 6000+ icons, free |
| `Image.asset("name")` | `Image("name")` | Asset catalog image |
| `Image.network(url)` | `AsyncImage(url: url)` | Network image with loading state |
| `Container()` | `Rectangle()` + modifiers | Decorated box |
| `Card()` | `RoundedRectangle()` + `.shadow()` | Card surface |
| `Divider()` | `Divider()` | Horizontal line separator |
| `CircularProgressIndicator()` | `ProgressView()` | Spinning loader |
| `LinearProgressIndicator()` | `ProgressView(value: x, total: 1.0)` | Progress bar |
| `Tooltip(message: "x")` | `.help("x")` | Tooltip on hover |
| `SelectableText()` | `Text().textSelection(.enabled)` | Selectable text |

---

## 🎮 Interactive

| Flutter | SwiftUI | Notes |
|---|---|---|
| `ElevatedButton()` | `Button().buttonStyle(.borderedProminent)` | Primary CTA button |
| `TextButton()` | `Button()` default style | Secondary/ghost button |
| `OutlinedButton()` | `Button().buttonStyle(.bordered)` | Outlined button |
| `IconButton()` | `Button { Image(systemName: "...") }` | Icon-only button |
| `TextField(controller: c)` | `TextField("label", text: $text)` | Single-line text input |
| `TextFormField()` | `TextField` + `.textFieldStyle()` | Styled text input |
| `Switch(value: x)` | `Toggle("label", isOn: $x)` | Boolean toggle |
| `Slider(value: x)` | `Slider(value: $x, in: 0...100)` | Range slider |
| `DropdownButton<T>()` | `Picker("label", selection: $x)` | Selection picker |
| `Checkbox(value: x)` | `Toggle` (custom label) | Checkbox |
| `GestureDetector(onTap:)` | `.onTapGesture { }` | Tap handler |
| `GestureDetector(onLongPress:)` | `.onLongPressGesture { }` | Long press |
| `Draggable / DragTarget` | `.draggable()` / `.dropDestination()` | Drag and drop |

---

## 🗺 Navigation

| Flutter | SwiftUI | Notes |
|---|---|---|
| `Navigator.push(context, route)` | `NavigationLink(value: item)` | Push a new screen |
| `Navigator.pop(context)` | `dismiss()` from `@Environment` | Pop / dismiss |
| `MaterialPageRoute` | *(handled by NavigationStack)* | Route definition implicit |
| `GoRouter` | `NavigationStack(path: $path)` | Programmatic router |
| `GoRoute(path: "/detail/:id")` | `.navigationDestination(for: T.self)` | Typed destination |
| `BottomNavigationBar` | `TabView + .tabItem { }` | Tab navigation |
| `showDialog()` | `.alert("title", isPresented: $x)` | Alert dialog |
| `showModalBottomSheet()` | `.sheet(isPresented: $x)` | Modal sheet |
| `showGeneralDialog()` | `.fullScreenCover(isPresented: $x)` | Full-screen overlay |
| `Drawer()` | `NavigationSplitView` / `.sheet` | Side navigation |
| `WillPopScope` | `.navigationBarBackButtonHidden` + custom | Control back behavior |

---

## ⚡ Concurrency

| Flutter | SwiftUI | Notes |
|---|---|---|
| `Future<T>` | `async throws -> T` | Async return value |
| `async / await` | `async / await` | Identical syntax |
| `try / catch` | `do / try / catch` | Error handling |
| `Future.wait([a, b])` | `async let a = ...; async let b = ...` | Parallel async |
| `Stream<T>` | `AsyncStream<T>` | Async sequence |
| `Isolate` | `Actor` | Isolated concurrent state |
| `compute(fn, data)` | `Task.detached { }` | Background work |
| `WidgetsBinding.instance.addPostFrameCallback` | `.onAppear { }` | After render hook |

---

## 🏗 Architecture

| Flutter | SwiftUI | Notes |
|---|---|---|
| `abstract class` | `protocol` | Interface / contract definition |
| `mixin` | `protocol extension` | Default implementation |
| `extension` methods | `extension` | Add methods to existing types |
| `sealed class` | `enum` with associated values | Exhaustive sum type |
| `factory constructor` | `static func make()` | Factory pattern |
| `final class` | `final class` | Non-subclassable class |
| `@immutable` | `struct` | Value type = immutable by default |

---

## 💾 Persistence

| Flutter | SwiftUI | Notes |
|---|---|---|
| `shared_preferences` | `@AppStorage("key")` | Key-value, backed by UserDefaults |
| `sqflite` | `SwiftData` | Structured local database |
| `Hive` | `SwiftData` | Similar ergonomics — macro-based |
| `path_provider` | `FileManager` | File system paths |
| `flutter_secure_storage` | `Keychain` (Security framework) | Encrypted storage |

---

## 🔧 Tooling

| Flutter | SwiftUI | Notes |
|---|---|---|
| `pubspec.yaml` | `Package.swift` | Dependency manifest |
| `pub.dev` | Swift Package Index (swiftpackageindex.com) | Package registry |
| `flutter run` | `Cmd + R` in Xcode | Run |
| `flutter build ios` | Product → Archive (Xcode) | Production build |
| `flutter test` | `Cmd + U` in Xcode | Run tests |
| `DartDoc` | DocC | Documentation |
| `flutter pub add X` | File → Add Package Dependencies | Add dependency |
| `analysis_options.yaml` | `.swiftlint.yml` (SwiftLint) | Linting rules |
