# 🧩 Components Reference

> Every common Flutter widget and its SwiftUI equivalent, with usage notes.

## Text & Typography

| Flutter | SwiftUI | Notes |
|---|---|---|
| `Text('hello')` | `Text("hello")` | — |
| `Text('hello', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))` | `Text("hello").font(.system(size: 18, weight: .bold))` | Modifier chaining |
| `Text('hello', style: theme.textTheme.titleLarge)` | `Text("hello").font(.title)` | Semantic fonts |
| `RichText(text: TextSpan(...))` | `Text("hello ") + Text("world").bold()` | Concatenate Text views |
| `SelectableText('copy me')` | `Text("copy me").textSelection(.enabled)` | — |

## Images

| Flutter | SwiftUI | Notes |
|---|---|---|
| `Image.asset('assets/photo.png')` | `Image("photo")` | From asset catalog |
| `Image.network(url)` | `AsyncImage(url: url)` | Shows placeholder while loading |
| `Image.network(url, loadingBuilder: ...)` | `AsyncImage(url:) { phase in ... }` | Full phase control |
| `Image(...)` + `BoxFit.cover` | `.resizable().scaledToFill()` | Fill mode |
| `Image(...)` + `BoxFit.contain` | `.resizable().scaledToFit()` | Fit mode |
| `ClipOval(child: Image(...))` | `Image(...).clipShape(Circle())` | Circular clip |

## Input

| Flutter | SwiftUI | Notes |
|---|---|---|
| `TextField(controller: TextEditingController())` | `TextField("label", text: $text)` | Binds to @State String |
| `TextField(obscureText: true)` | `SecureField("Password", text: $password)` | Password input |
| `TextField(keyboardType: TextInputType.number)` | `TextField(...).keyboardType(.numberPad)` | Keyboard type |
| `TextField(maxLines: null)` | `TextEditor(text: $text)` | Multi-line |
| `Switch(value: x, onChanged: f)` | `Toggle("label", isOn: $x)` | — |
| `Slider(value: x, onChanged: f)` | `Slider(value: $x, in: min...max)` | — |
| `DropdownButton<T>` | `Picker("label", selection: $x) { ForEach(options) { Text($0) } }` | — |
| `DatePicker` | `DatePicker("label", selection: $date, displayedComponents: .date)` | — |
| `Stepper(value: 0, onChanged: f)` | `Stepper("label", value: $x)` | — |

## Buttons

| Flutter | SwiftUI | Notes |
|---|---|---|
| `ElevatedButton(onPressed: f, child: Text('ok'))` | `Button("ok") { f() }.buttonStyle(.borderedProminent)` | — |
| `TextButton(onPressed: f, child: Text('ok'))` | `Button("ok") { f() }` | Default style |
| `OutlinedButton(onPressed: f, child: Text('ok'))` | `Button("ok") { f() }.buttonStyle(.bordered)` | — |
| `IconButton(onPressed: f, icon: Icon(Icons.add))` | `Button { Image(systemName: "plus") } action: { f() }` | — |
| `PopupMenuButton<T>` | `Menu("Options") { Button("Edit") {}; Button("Delete", role: .destructive) {} }` | — |

## Layout & Containers

| Flutter | SwiftUI | Notes |
|---|---|---|
| `Scaffold(appBar:, body:, fab:)` | `NavigationStack + .toolbar { }` | No Scaffold concept |
| `AppBar(title: Text('Title'))` | `.navigationTitle("Title")` | On the content view |
| `Container(color: Colors.blue)` | `Color.blue` or `Rectangle().fill(.blue)` | — |
| `Container(decoration: BoxDecoration(...))` | Chain `.background()`, `.cornerRadius()`, `.shadow()` | Modifiers |
| `Card(child: ...)` | `content.background(.background).cornerRadius(12).shadow(radius:4)` | — |
| `Chip(label: Text('Tag'))` | `Text("Tag").padding(.horizontal,10).background(.secondary.opacity(0.15)).clipShape(Capsule())` | — |
| `Divider()` | `Divider()` | — |

## Lists

| Flutter | SwiftUI | Notes |
|---|---|---|
| `ListView.builder(itemCount:, itemBuilder:)` | `List(items) { item in ... }` | Lazy by default |
| `ListView(children: [...])` | `List { Text("a"); Text("b") }` | Static list |
| `ListTile(title:, subtitle:, leading:, trailing:)` | Custom `HStack` in List row | No ListTile — compose manually |
| `Dismissible(key:, onDismissed:, child:)` | `ForEach.onDelete { indexSet in ... }` | Built into ForEach |
| `ReorderableListView` | `ForEach.onMove { from, to in ... }` + `EditButton()` | Built in |
| `GridView.count(crossAxisCount: 2)` | `LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())])` | — |
| `GridView.extent(maxCrossAxisExtent: 150)` | `LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))])` | Adaptive |

## Feedback & Overlays

| Flutter | SwiftUI | Notes |
|---|---|---|
| `CircularProgressIndicator()` | `ProgressView()` | — |
| `LinearProgressIndicator(value: 0.7)` | `ProgressView(value: 0.7)` | — |
| `showDialog(...)` | `.alert(...)` | — |
| `showModalBottomSheet(...)` | `.sheet(isPresented: $x)` | — |
| `Tooltip(message: 'info', child: ...)` | `.help("info")` | — |
| `Badge(label: Text('3'))` | `.badge(3)` on TabItem or button | — |

## System Integration (SwiftUI-Only)

| SwiftUI | Description |
|---|---|
| `ShareLink(item: url)` | System share sheet — one line |
| `PhotosPicker` | Photos library picker |
| `Map(position: $region)` | Native MapKit |
| `WidgetKit` | Home screen & Lock Screen widgets |
| `AppIntents` | Siri, Spotlight, Shortcuts integration |
| `StoreKit` | In-app purchases, native UI |
