# MVVM in SwiftUI

## Complete MVVM Example

```swift
// ── Model ──────────────────────────────────────────────────
struct Post: Codable, Identifiable {
  let id: Int
  let title: String
  let body: String
}

// ── ViewModel ──────────────────────────────────────────────
@Observable @MainActor
class PostsViewModel {
  var posts: [Post] = []
  var isLoading = false
  var errorMessage: String?
  var searchText = ""

  var filteredPosts: [Post] {
    searchText.isEmpty ? posts : posts.filter {
      $0.title.localizedCaseInsensitiveContains(searchText)
    }
  }

  func loadPosts() async {
    isLoading = true
    defer { isLoading = false }
    do {
      let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
      let (data, _) = try await URLSession.shared.data(from: url)
      posts = try JSONDecoder().decode([Post].self, from: data)
    } catch {
      errorMessage = error.localizedDescription
    }
  }
}

// ── View ───────────────────────────────────────────────────
struct PostsView: View {
  @State private var viewModel = PostsViewModel()

  var body: some View {
    NavigationStack {
      Group {
        if viewModel.isLoading {
          ProgressView("Loading...")
        } else if let error = viewModel.errorMessage {
          ContentUnavailableView("Error", systemImage: "wifi.slash", description: Text(error))
        } else {
          List(viewModel.filteredPosts) { post in
            NavigationLink(value: post) {
              PostRow(post: post)
            }
          }
          .searchable(text: $viewModel.searchText)
        }
      }
      .navigationTitle("Posts")
      .navigationDestination(for: Post.self) { PostDetailView(post: $0) }
      .task { await viewModel.loadPosts() }
      .refreshable { await viewModel.loadPosts() }
    }
  }
}

struct PostRow: View {
  let post: Post
  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      Text(post.title).font(.headline).lineLimit(1)
      Text(post.body).font(.caption).foregroundStyle(.secondary).lineLimit(2)
    }
    .padding(.vertical, 4)
  }
}
```

## Flutter Equivalent Structure

```dart
// Flutter — same pattern, more boilerplate
class PostsViewModel extends ChangeNotifier {
  List<Post> _posts = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _searchText = '';

  List<Post> get filteredPosts => _searchText.isEmpty
    ? _posts
    : _posts.where((p) => p.title.toLowerCase().contains(_searchText.toLowerCase())).toList();

  set searchText(String value) {
    _searchText = value;
    notifyListeners();
  }

  Future<void> loadPosts() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      _posts = (jsonDecode(response.body) as List).map((e) => Post.fromJson(e)).toList();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
```

## Recommended Folder Structure

```
MyApp/
├── MyAppApp.swift           ← @main entry point
├── ContentView.swift        ← Root view
├── Models/
│   ├── User.swift           ← @Model or struct
│   └── Post.swift
├── ViewModels/
│   ├── UserViewModel.swift  ← @Observable classes
│   └── PostViewModel.swift
├── Views/
│   ├── Home/
│   │   ├── HomeView.swift
│   │   └── HomeRow.swift
│   ├── Profile/
│   │   └── ProfileView.swift
│   └── Shared/
│       └── LoadingView.swift
├── Services/
│   ├── NetworkService.swift
│   └── AuthService.swift
└── Assets.xcassets
```
