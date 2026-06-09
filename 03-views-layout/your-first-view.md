# Your First View

## The Anatomy Comparison

```dart
// Flutter — class extending StatelessWidget
class ProfileCard extends StatelessWidget {
  final String name;
  final String role;
  final String avatarUrl;

  const ProfileCard({
    super.key,
    required this.name,
    required this.role,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(blurRadius: 8, color: Colors.black12)],
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundImage: NetworkImage(avatarUrl)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(role),
            ],
          ),
        ],
      ),
    );
  }
}
```

```swift
// SwiftUI — struct conforming to View protocol
struct ProfileCard: View {
  let name: String
  let role: String
  let avatarURL: URL

  var body: some View {
    HStack(spacing: 12) {
      AsyncImage(url: avatarURL) { image in
        image.resizable().scaledToFill()
      } placeholder: {
        Circle().fill(.secondary)
      }
      .frame(width: 44, height: 44)
      .clipShape(Circle())

      VStack(alignment: .leading) {
        Text(name).fontWeight(.bold)
        Text(role).foregroundStyle(.secondary)
      }
    }
    .padding(16)
    .background(.background)
    .cornerRadius(12)
    .shadow(color: .black.opacity(0.08), radius: 8)
  }
}

// Live preview — no app needed
#Preview {
  ProfileCard(
    name: "Alice",
    role: "iOS Developer",
    avatarURL: URL(string: "https://i.pravatar.cc/150")!
  )
  .padding()
}
```

## Key Structural Differences

| Flutter | SwiftUI |
|---|---|
| `class extends StatelessWidget` | `struct : View` |
| `Widget build(BuildContext)` | `var body: some View` |
| Properties declared in class | Properties declared in struct |
| `const Constructor({super.key, required...})` | No key, no super.init |
| `@override Widget build(context) { return ... }` | `var body: some View { ... }` |
| Wrap with Container, ClipRRect, etc. | Chain modifiers directly |

## `some View` — What Is It?

`some View` is an *opaque return type*. It means "some specific concrete type that conforms to View — the compiler knows what it is, you don't need to name it." This lets SwiftUI diff the view tree efficiently without boxing.

Think of it as the Swift equivalent of returning `Widget` — except the compiler verifies the concrete type for performance.
