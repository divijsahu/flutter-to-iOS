# Collections

> Arrays, dictionaries, and sets map almost directly. The main difference: Swift uses `[Type]` for arrays and `[Key: Value]` for dictionaries — no `List<>` or `Map<>` generics.

## Arrays

```dart
// Dart
var fruits = ['apple', 'banana', 'cherry'];
fruits.add('date');
fruits.removeAt(0);
fruits.length;
fruits.contains('banana');
fruits.first;
fruits.last;
fruits.reversed.toList();
fruits.where((f) => f.length > 5).toList();
fruits.map((f) => f.toUpperCase()).toList();
fruits.sort();
```

```swift
// Swift
var fruits = ["apple", "banana", "cherry"]
fruits.append("date")
fruits.remove(at: 0)
fruits.count
fruits.contains("banana")
fruits.first                 // Optional<String> — could be nil if empty
fruits.last                  // Optional<String>
fruits.reversed()
fruits.filter { $0.count > 5 }
fruits.map { $0.uppercased() }
fruits.sorted()              // returns new sorted array
fruits.sort()                // sorts in place
```

## Dictionaries

```dart
// Dart
var scores = <String, int>{'Alice': 95, 'Bob': 87};
scores['Alice'];                    // 95
scores['Charlie'];                  // null
scores['Charlie'] ?? 0;             // 0
scores['Dave'] = 91;
scores.remove('Bob');
scores.keys.toList();
scores.values.toList();
scores.entries.map((e) => '${e.key}: ${e.value}');
```

```swift
// Swift
var scores: [String: Int] = ["Alice": 95, "Bob": 87]
scores["Alice"]                     // Optional(95)
scores["Charlie"]                   // nil
scores["Charlie", default: 0]       // 0  ← much cleaner than ?? 0
scores["Dave"] = 91
scores.removeValue(forKey: "Bob")
scores.keys
scores.values
scores.map { "\($0.key): \($0.value)" }
```

## Sets

```dart
// Dart
var colors = <String>{'red', 'green', 'blue'};
colors.add('red');           // no duplicate — still 3 elements
colors.contains('red');
colors.intersection({'red', 'yellow'});
colors.union({'yellow', 'purple'});
```

```swift
// Swift
var colors: Set<String> = ["red", "green", "blue"]
colors.insert("red")         // no duplicate
colors.contains("red")
colors.intersection(["red", "yellow"])
colors.union(["yellow", "purple"])
```

## Higher-Order Functions

```dart
// Dart
final nums = [1, 2, 3, 4, 5];
nums.map((n) => n * 2);              // (2, 4, 6, 8, 10) — lazy Iterable
nums.map((n) => n * 2).toList();     // [2, 4, 6, 8, 10] — eager List
nums.where((n) => n.isEven);         // (2, 4)
nums.reduce((a, b) => a + b);        // 15
nums.fold(0, (acc, n) => acc + n);   // 15
nums.any((n) => n > 3);              // true
nums.every((n) => n > 0);            // true
nums.take(3).toList();               // [1, 2, 3]
nums.skip(2).toList();               // [3, 4, 5]
```

```swift
// Swift — identical concepts, slightly different names
let nums = [1, 2, 3, 4, 5]
nums.map { $0 * 2 }               // [2, 4, 6, 8, 10] — eager by default
nums.lazy.map { $0 * 2 }          // lazy (explicit)
nums.filter { $0.isMultiple(of: 2) } // [2, 4]
nums.reduce(0, +)                 // 15
nums.reduce(0) { $0 + $1 }        // 15
nums.contains { $0 > 3 }          // true
nums.allSatisfy { $0 > 0 }        // true
Array(nums.prefix(3))             // [1, 2, 3]
Array(nums.dropFirst(2))          // [3, 4, 5]
```
