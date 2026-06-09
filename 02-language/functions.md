# Functions

> **The key difference:** Swift has *external* and *internal* parameter labels. The name you see at the call site can differ from the name inside the function body. This makes Swift APIs read like English sentences.

## Basic Functions

```dart
// Dart — positional + named parameters
String greet(String name, {int age = 0, bool formal = false}) {
  return formal ? 'Good day, $name' : 'Hey $name ($age)';
}

greet('Alice');                    // Hey Alice (0)
greet('Bob', age: 30);             // Hey Bob (30)
greet('Eve', formal: true);        // Good day, Eve
```

```swift
// Swift — external label _ removes label; default = external same as internal
func greet(_ name: String, age: Int = 0, formal: Bool = false) -> String {
  return formal ? "Good day, \(name)" : "Hey \(name) (\(age))"
}

greet("Alice")                     // Hey Alice (0)
greet("Bob", age: 30)              // Hey Bob (30)
greet("Eve", formal: true)         // Good day, Eve
```

## External vs Internal Labels (Swift-only)

```swift
// Read like English at call site, clean inside the function
func move(from start: Int, to end: Int) {
  print("Moving from \(start) to \(end)")  // uses internal labels
}
move(from: 0, to: 10)  // reads naturally at call site

func insert(_ value: Int, at index: Int) {
  // _ removes external label for first param
}
insert(42, at: 3)
```

## Closures

```dart
// Dart
var add = (int a, int b) => a + b;
var greet = (String name) { return 'Hi $name'; };

// Higher-order
[1, 2, 3].map((e) => e * 2).toList();   // [2, 4, 6]
[1, 2, 3].where((e) => e > 1).toList(); // [2, 3]
[1, 2, 3].reduce((a, b) => a + b);      // 6
```

```swift
// Swift — trailing closure syntax, shorthand args ($0, $1...)
let add = { (a: Int, b: Int) -> Int in a + b }
let greet: (String) -> String = { "Hi \($0)" }  // $0 = first arg

// Higher-order (trailing closures look cleaner than Dart)
[1, 2, 3].map { $0 * 2 }        // [2, 4, 6]
[1, 2, 3].filter { $0 > 1 }     // [2, 3]
[1, 2, 3].reduce(0, +)          // 6  (pass operator directly!)
[1, 2, 3].reduce(0) { $0 + $1 } // same
```

## Function Types

```dart
// Dart function types
void Function(int) callback;
Future<String> Function(String) asyncFn;
```

```swift
// Swift function types
var callback: (Int) -> Void
var asyncFn: (String) async throws -> String
```
