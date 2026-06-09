# Error Handling

> **Key difference:** Dart throws any object. Swift uses typed `Error` protocol conformance and marks throwing functions explicitly with `throws`. The `try?` operator is a powerful Swift addition.

## Defining Errors

```dart
// Dart
class NetworkError implements Exception {
  final String message;
  NetworkError(this.message);

  @override
  String toString() => 'NetworkError: $message';
}

// Or just throw anything:
throw 'something went wrong';
throw 42;
```

```swift
// Swift — conform to Error protocol
enum NetworkError: Error {
  case notFound
  case unauthorized
  case serverError(Int)          // associated value with status code
  case message(String)
}

// LocalizedError gives user-readable messages
enum NetworkError: LocalizedError {
  case notFound
  var errorDescription: String? {
    switch self {
    case .notFound: return "Resource not found"
    }
  }
}
```

## Throwing and Catching

```dart
// Dart
Future<String> fetchData(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 404) {
    throw NetworkError('Not found');
  }
  return response.body;
}

// Calling
try {
  final data = await fetchData('https://api.example.com/data');
  print(data);
} catch (e) {
  print('Error: $e');
} finally {
  print('done');
}
```

```swift
// Swift — functions must be marked `throws`
func fetchData(from url: URL) async throws -> String {
  let (data, response) = try await URLSession.shared.data(from: url)
  guard let http = response as? HTTPURLResponse, http.statusCode != 404 else {
    throw NetworkError.notFound
  }
  return String(data: data, encoding: .utf8) ?? ""
}

// Calling
do {
  let data = try await fetchData(from: url)
  print(data)
} catch NetworkError.notFound {
  print("Not found")
} catch NetworkError.serverError(let code) {
  print("Server error: \(code)")
} catch {
  print("Unknown error: \(error)")    // `error` is implicit in catch
}

// try? — converts throws into Optional (returns nil on error)
let data = try? fetchData(from: url)  // String? — nil if throws

// try! — force try, crashes on error (avoid in production)
let data = try! loadFromBundle()      // only if you're 100% sure it won't throw
```

## Result Type

```dart
// Dart — no built-in Result, use packages or pattern match
sealed class Result<T> {
  const Result();
}
class Success<T> extends Result<T> {
  final T value;
  const Success(this.value);
}
class Failure<T> extends Result<T> {
  final Exception error;
  const Failure(this.error);
}
```

```swift
// Swift — Result<Success, Failure> is built in
func loadUser(id: Int) -> Result<User, NetworkError> {
  guard id > 0 else { return .failure(.notFound) }
  return .success(User(id: id, name: "Alice"))
}

switch loadUser(id: 1) {
case .success(let user): print(user.name)
case .failure(let error): print(error)
}

// Get value or throw
let user = try loadUser(id: 1).get()
```
