# @Observable vs ChangeNotifier

> The most common state management pattern for non-trivial apps. `@Observable` (iOS 17+) is to SwiftUI what `ChangeNotifier + Provider` is to Flutter — but far less boilerplate.

## Side-by-Side: Todo List

```dart
// Flutter — ChangeNotifier + Provider
class TodoModel extends ChangeNotifier {
  final List<String> _todos = [];
  List<String> get todos => List.unmodifiable(_todos);

  void add(String todo) {
    _todos.add(todo);
    notifyListeners();          // must call manually
  }

  void remove(int index) {
    _todos.removeAt(index);
    notifyListeners();          // easy to forget
  }
}

// Setup at app root
ChangeNotifierProvider(
  create: (_) => TodoModel(),
  child: const MyApp(),
)

// In a widget
final model = context.watch<TodoModel>();
// or
final model = Provider.of<TodoModel>(context);
model.todos;

// Trigger action
context.read<TodoModel>().add('Buy milk');
```

```swift
// SwiftUI — @Observable
@Observable
class TodoModel {
  var todos: [String] = []    // all stored properties are automatically tracked

  func add(_ todo: String) {
    todos.append(todo)          // no notifyListeners() — SwiftUI tracks access
  }

  func remove(at offsets: IndexSet) {
    todos.remove(atOffsets: offsets)
  }
}

// Setup — just create it
struct MyApp: App {
  let todoModel = TodoModel()

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(todoModel)    // inject once
    }
  }
}

// In a view
struct TodoList: View {
  @Environment(TodoModel.self) var model   // read from environment

  var body: some View {
    List {
      ForEach(model.todos, id: \.self) { Text($0) }
        .onDelete { model.remove(at: $0) }
    }
    .toolbar {
      Button("Add") { model.add("New todo") }
    }
  }
}
```

## What @Observable Does Under the Hood

- At compile time, `@Observable` macro synthesizes observation tracking
- When a view reads `model.todos`, Swift registers that access
- When `model.todos` changes, only views that *read* that property re-render
- Fine-grained — changing `model.userName` doesn't re-render a view that only reads `model.todos`
- No manual `notifyListeners()` — observation is automatic

## Migration: ObservableObject → @Observable

```swift
// Old approach (still works, but @Observable is preferred in Xcode 26)
class OldViewModel: ObservableObject {
  @Published var count = 0       // must mark each property
  @Published var name = ""
}
@StateObject var vm = OldViewModel()  // or @ObservedObject

// New approach — simpler
@Observable
class ViewModel {
  var count = 0                  // all stored props are observed automatically
  var name = ""
}
@State var vm = ViewModel()      // just @State — no need for @StateObject
```
