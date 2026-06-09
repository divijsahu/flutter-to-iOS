enum Priority { low, medium, high }

extension PriorityLabel on Priority {
  String get label => name[0].toUpperCase() + name.substring(1);
}

class TodoItem {
  final String id;
  String title;
  bool isDone;
  Priority priority;
  final DateTime createdAt;

  TodoItem({
    required this.title,
    this.priority = Priority.medium,
  })  : id = DateTime.now().toIso8601String(),
        isDone = false,
        createdAt = DateTime.now();
}
