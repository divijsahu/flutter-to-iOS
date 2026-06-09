# Async / Await

## Basic Async Functions

```dart
// Dart
Future<User> fetchUser(int id) async {
  final response = await http.get(Uri.parse('https://api.example.com/users/$id'));
  if (response.statusCode != 200) throw Exception('Failed');
  return User.fromJson(jsonDecode(response.body));
}

try {
  final user = await fetchUser(1);
  print(user.name);
} catch (e) {
  print('Error: $e');
}
```

```swift
// Swift — identical structure, different syntax
func fetchUser(id: Int) async throws -> User {
  let url = URL(string: "https://api.example.com/users/\(id)")!
  let (data, response) = try await URLSession.shared.data(from: url)
  guard (response as? HTTPURLResponse)?.statusCode == 200 else {
    throw NetworkError.serverError
  }
  return try JSONDecoder().decode(User.self, from: data)
}

do {
  let user = try await fetchUser(id: 1)
  print(user.name)
} catch {
  print("Error: \(error)")
}
```

## .task Modifier — Replaces FutureBuilder

```dart
// Flutter — FutureBuilder
FutureBuilder<User>(
  future: fetchUser(1),
  builder: (context, snapshot) {
    if (snapshot.hasError) return Text('Error: ${snapshot.error}');
    if (!snapshot.hasData) return const CircularProgressIndicator();
    return Text(snapshot.data!.name);
  },
)
```

```swift
// SwiftUI — .task modifier (auto-cancels when view disappears)
struct UserView: View {
  @State private var user: User?
  @State private var error: String?

  var body: some View {
    Group {
      if let error {
        ContentUnavailableView("Error", systemImage: "exclamationmark.triangle", description: Text(error))
      } else if let user {
        Text(user.name)
      } else {
        ProgressView()
      }
    }
    .task {
      do {
        user = try await fetchUser(id: 1)
      } catch {
        self.error = error.localizedDescription
      }
    }
  }
}
```

## Parallel Async — async let

```dart
// Dart — Future.wait
final results = await Future.wait([
  fetchUser(1),
  fetchPosts(userId: 1),
  fetchFollowers(userId: 1),
]);
final user = results[0] as User;
final posts = results[1] as List<Post>;
final followers = results[2] as List<User>;
```

```swift
// Swift — async let (fires all three simultaneously, type-safe)
async let user = fetchUser(id: 1)
async let posts = fetchPosts(userId: 1)
async let followers = fetchFollowers(userId: 1)

let (u, p, f) = try await (user, posts, followers)
// All three ran in parallel — total time = slowest one, not sum of all
```

## Codable — Automatic JSON

```dart
// Dart — requires fromJson factory (or json_serializable)
class User {
  final int id;
  final String name;
  final String email;

  const User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] as int,
    name: json['name'] as String,
    email: json['email'] as String,
  );
}
```

```swift
// Swift — Codable does it all automatically
struct User: Codable, Identifiable {
  let id: Int
  let name: String
  let email: String
}
// That's the entire model. Encoding and decoding work automatically.

let user = try JSONDecoder().decode(User.self, from: data)

// Snake_case keys — use decoder setting
let decoder = JSONDecoder()
decoder.keyDecodingStrategy = .convertFromSnakeCase
let user = try decoder.decode(User.self, from: data)
```
