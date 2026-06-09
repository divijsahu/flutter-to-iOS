# Enums

> **Swift enums are a superpower.** Unlike Dart enums (even enhanced ones), Swift enums can carry different data in each case — called *associated values*. This enables expressive state modeling that would require multiple classes in Dart.

## Basic Enums

```dart
// Dart
enum Direction { north, south, east, west }
enum Status { loading, success, error }

Direction.north.name;       // 'north'
```

```swift
// Swift
enum Direction { case north, south, east, west }
enum Status { case loading, success, error }

Direction.north             // .north (type inferred)
```

## Associated Values (Swift's Superpower)

```dart
// Dart — no native associated values, requires sealed classes
sealed class Result {}
class Loading extends Result {}
class Success extends Result {
  final String data;
  Success(this.data);
}
class Failure extends Result {
  final String message;
  Failure(this.message);
}
```

```swift
// Swift — one enum, multiple shapes of data per case
enum Result {
  case loading
  case success(String)
  case failure(String, Int)   // message + status code
}

// Pattern matching with switch (must be exhaustive)
switch result {
case .loading:
  ProgressView()
case .success(let data):
  Text(data)
case .failure(let message, let code):
  Text("Error \(code): \(message)")
}
```

## Raw Values

```dart
// Dart enhanced enum
enum Planet {
  mercury(1), venus(2), earth(3);
  final int order;
  const Planet(this.order);
}
```

```swift
// Swift raw values
enum Planet: Int {
  case mercury = 1
  case venus              // auto-increments to 2
  case earth              // 3

  static var habitable: [Planet] { [.earth] }
}

Planet.earth.rawValue   // 3
Planet(rawValue: 2)     // Optional(.venus)

// String raw values
enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
}
HTTPMethod.post.rawValue    // "POST"
```

## Enum Methods and Properties

```swift
// Enums can have computed properties and methods
enum Suit: String, CaseIterable {
  case hearts = "♥️", diamonds = "♦️", clubs = "♣️", spades = "♠️"

  var color: String {
    switch self {
    case .hearts, .diamonds: return "red"
    case .clubs, .spades: return "black"
    }
  }

  func beats(_ other: Suit) -> Bool {
    // game logic
    return false
  }
}

Suit.allCases.map { $0.rawValue }   // ["♥️", "♦️", "♣️", "♠️"]
Suit.hearts.color                   // "red"
```
