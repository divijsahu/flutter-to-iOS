# Lists & ForEach

## List vs ListView.builder

```dart
// Flutter — ListView.builder (lazy by default)
ListView.builder(
  itemCount: contacts.length,
  itemBuilder: (context, index) {
    final contact = contacts[index];
    return ListTile(
      leading: CircleAvatar(child: Text(contact.initials)),
      title: Text(contact.name),
      subtitle: Text(contact.email),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => Navigator.push(context, ...),
    );
  },
)
```

```swift
// SwiftUI — List with ForEach
// Contact must be Identifiable
struct Contact: Identifiable {
  let id = UUID()
  var name: String
  var email: String
  var initials: String { String(name.prefix(2)).uppercased() }
}

List(contacts) { contact in
  HStack {
    Circle()
      .fill(.blue.opacity(0.2))
      .frame(width: 40, height: 40)
      .overlay(Text(contact.initials).font(.caption))
    VStack(alignment: .leading) {
      Text(contact.name).fontWeight(.medium)
      Text(contact.email).font(.caption).foregroundStyle(.secondary)
    }
    Spacer()
    Image(systemName: "chevron.right")
      .foregroundStyle(.tertiary)
      .font(.caption)
  }
}
```

## ForEach — When to Use It

```swift
// List handles scrolling, sections, swipe actions automatically
List {
  ForEach(contacts) { contact in
    ContactRow(contact: contact)
  }
  .onDelete { indexSet in
    contacts.remove(atOffsets: indexSet)   // swipe-to-delete built in
  }
  .onMove { from, to in
    contacts.move(fromOffsets: from, toOffset: to)  // drag-to-reorder
  }
}
.toolbar {
  EditButton()  // toggles edit mode automatically
}

// ForEach without List — for embedding in VStack/HStack
VStack {
  ForEach(tags, id: \.self) { tag in
    Text(tag)
      .padding(.horizontal, 10)
      .background(.secondary.opacity(0.15))
      .clipShape(Capsule())
  }
}
```

## Sections

```dart
// Flutter sections (manual)
ListView(children: [
  const ListTile(title: Text('CONTACTS', style: TextStyle(fontSize: 11))),
  ...contactWidgets,
  const ListTile(title: Text('RECENTS')),
  ...recentWidgets,
])
```

```swift
// SwiftUI sections (built in, with sticky headers)
List {
  Section("Contacts") {
    ForEach(contacts) { ContactRow(contact: $0) }
  }
  Section("Recents") {
    ForEach(recents) { ContactRow(contact: $0) }
  }
}
.listStyle(.insetGrouped)    // iOS grouped appearance
```

## Pull to Refresh

```dart
// Flutter
RefreshIndicator(
  onRefresh: () async { await viewModel.reload(); },
  child: ListView.builder(...),
)
```

```swift
// SwiftUI
List(contacts) { ContactRow(contact: $0) }
  .refreshable {
    await viewModel.reload()    // async/await, no completion needed
  }
```
