# Optionals

> **This is the most important conceptual difference in the language.** Swift's optional system is richer than Dart's null safety. The `guard let` pattern in particular has no direct Dart equivalent — learn it early.

## Declaring Optionals

```dart
// Dart
String? name;               // nullable String — same syntax as Swift!
int? count;
List<String>? items;
```

```swift
// Swift — identical syntax for declaration
var name: String?
var count: Int?
var items: [String]?
```

## Accessing Optional Values

```dart
// Dart
name?.length;               // null-conditional: returns null if name is null
name ?? 'default';          // null-coalescing: fallback value
name!.length;               // force unwrap: crashes if null — avoid

// Pattern matching (Dart 3+)
if (name case var n?) {
  print(n);                 // n is String (non-null) here
}
```

```swift
// Swift — more ways to safely unwrap
name?.count              // optional chaining: nil if name is nil
name ?? "default"        // nil-coalescing: identical to Dart's ??
name!.count              // force unwrap: crashes if nil — avoid

// if let — safest, most common (no Dart equivalent)
if let n = name {
  print(n)               // n is String, not String?
}

// Shorthand if let (Swift 5.7+)
if let name {            // same name — no = needed
  print(name)
}

// guard let — early exit pattern (very idiomatic Swift)
func process(name: String?) {
  guard let name else { return }  // bail if nil
  print(name)            // name is String from here down — no nesting!
}

// Optional chaining chains
user?.profile?.avatar?.url?.absoluteString
```

## Why `guard let` Matters

```dart
// Dart — forced to nest
void processUser(User? user) {
  if (user != null) {
    if (user.profile != null) {
      print(user.profile!.name);
    }
  }
}
```

```swift
// Swift — guard keeps code flat
func processUser(_ user: User?) {
  guard let user else { return }
  guard let profile = user.profile else { return }
  print(profile.name)    // flat, readable, no nesting
}
```

## Optional Chaining vs Force Unwrap

```swift
// Safe — returns nil instead of crashing
let count = name?.count           // Int?
let upper = name?.uppercased()    // String?

// Provide default with ??
let count = name?.count ?? 0      // Int (not optional)

// Force unwrap — only when you're 100% certain
let url = URL(string: "https://apple.com")!  // URL literals are always valid
```
