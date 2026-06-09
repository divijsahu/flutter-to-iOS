# Variables & Constants

> **The core difference:** Dart has three keywords (`var`, `final`, `const`). Swift has two (`var`, `let`). Swift's `let` covers both cases — it's immutable and the compiler enforces it.

## Side-by-Side

```dart
// Dart
var name = 'Alice';           // mutable, inferred String
final age = 30;               // runtime constant
const pi = 3.14159;           // compile-time constant
String? nickname;             // nullable
late String greeting;         // late initialization — must assign before use

// String interpolation
var msg = 'Hello $name, next year you\'ll be ${age + 1}';
```

```swift
// Swift
var name = "Alice"            // mutable, inferred String
let age = 30                  // constant (covers both final + const)
let pi = 3.14159              // also a constant — no separate keyword
var nickname: String?         // optional (nullable)
lazy var greeting = makeGreeting()  // lazy — computed on first access

// String interpolation (backslash-paren, must use double quotes)
let msg = "Hello \(name), next year you'll be \(age + 1)"
```

## Key Differences

| Dart | Swift | Note |
|---|---|---|
| `var` | `var` | Mutable, type inferred |
| `final` | `let` | Immutable at runtime |
| `const` | `let` | Swift `let` is always constant — same keyword |
| `String?` | `String?` | Optional (nullable) — identical syntax |
| `late String x` | `lazy var x = expr()` | Deferred init — Swift requires an initial expression |
| `'single quotes'` | `"double quotes only"` | Swift requires double quotes for strings |

## Type Annotations

```dart
// Dart — explicit types
String name = 'Alice';
int count = 0;
double price = 9.99;
bool isActive = true;
List<String> tags = [];
Map<String, int> scores = {};
```

```swift
// Swift — explicit types (rarely needed, inference is strong)
let name: String = "Alice"
var count: Int = 0
let price: Double = 9.99
var isActive: Bool = true
var tags: [String] = []
var scores: [String: Int] = [:]
```
