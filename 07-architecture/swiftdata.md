# SwiftData

> SwiftData is the modern replacement for CoreData. It's to CoreData what `@Observable` is to `NSObject KVO` — same power, 90% less code. For Flutter devs: think of it as `sqflite` or `Hive` but with zero setup and native Swift syntax.

## Setup vs Flutter

```dart
// Flutter — sqflite setup
Future<Database> _initDatabase() async {
  final dbPath = await getDatabasesPath();
  return openDatabase(
    join(dbPath, 'todos.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, isDone INTEGER)',
      );
    },
    version: 1,
  );
}
```

```swift
// SwiftData — mark your model, add one line to app entry
@Model
class Todo {
  var title: String
  var isDone: Bool
  var createdAt: Date

  init(title: String) {
    self.title = title
    self.isDone = false
    self.createdAt = Date()
  }
}

@main
struct MyApp: App {
  var body: some Scene {
    WindowGroup { ContentView() }
      .modelContainer(for: Todo.self)   // ← one line. Schema created, migrations handled.
  }
}
```

## CRUD Operations

```dart
// Flutter — sqflite CRUD
await db.insert('todos', todo.toMap());
final maps = await db.query('todos', orderBy: 'createdAt DESC');
await db.update('todos', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
await db.delete('todos', where: 'id = ?', whereArgs: [todo.id]);
```

```swift
// SwiftData — Swift-native CRUD
struct TodoList: View {
  @Environment(\.modelContext) private var context
  @Query(sort: \Todo.createdAt, order: .reverse) private var todos: [Todo]

  var body: some View {
    List {
      ForEach(todos) { todo in
        HStack {
          Image(systemName: todo.isDone ? "checkmark.circle.fill" : "circle")
            .onTapGesture { todo.isDone.toggle() }    // Update: just mutate
          Text(todo.title)
        }
      }
      .onDelete { indexSet in
        indexSet.map { todos[$0] }.forEach { context.delete($0) }  // Delete
      }
    }
    .toolbar {
      Button("Add") {
        context.insert(Todo(title: "New Todo"))         // Insert
      }
    }
  }
}
// No explicit save needed — modelContext auto-saves
```

## Filtering and Sorting

```swift
// @Query with predicate
@Query(filter: #Predicate<Todo> { !$0.isDone },
       sort: \Todo.createdAt)
private var activeTodos: [Todo]

// Dynamic fetch descriptor
var descriptor: FetchDescriptor<Todo> {
  FetchDescriptor(
    predicate: showCompleted ? nil : #Predicate { !$0.isDone },
    sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
  )
}
```

## Relationships

```swift
@Model
class Project {
  var name: String
  @Relationship(deleteRule: .cascade) var todos: [Todo] = []

  init(name: String) { self.name = name }
}

@Model
class Todo {
  var title: String
  var project: Project?    // inverse relationship — automatic
  init(title: String) { self.title = title }
}
```
