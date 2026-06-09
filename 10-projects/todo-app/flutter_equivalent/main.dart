import 'package:flutter/material.dart';
import 'todo_model.dart';

void main() => runApp(const TodoApp());

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasks',
      theme: ThemeData.dark(useMaterial3: true),
      home: const TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<TodoItem> _todos = [];

  int get _pendingCount => _todos.where((t) => !t.isDone).length;

  void _addTodo(String title, Priority priority) {
    setState(() => _todos.insert(0, TodoItem(title: title, priority: priority)));
  }

  void _toggleTodo(TodoItem todo) {
    setState(() => todo.isDone = !todo.isDone);
  }

  void _deleteTodo(int index) {
    setState(() => _todos.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle),
            onPressed: () => _showAddSheet(context),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Center(
          child: Text(
            _pendingCount == 0 ? 'All done! 🎉' : '$_pendingCount remaining',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ),
      body: ReorderableListView.builder(
        itemCount: _todos.length,
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) newIndex--;
            final item = _todos.removeAt(oldIndex);
            _todos.insert(newIndex, item);
          });
        },
        itemBuilder: (context, index) {
          final todo = _todos[index];
          return Dismissible(
            key: ValueKey(todo.id),
            onDismissed: (_) => _deleteTodo(index),
            background: Container(color: Colors.red),
            child: ListTile(
              key: ValueKey(todo.id),
              leading: IconButton(
                icon: Icon(
                  todo.isDone ? Icons.check_circle : Icons.circle_outlined,
                  color: todo.isDone ? Colors.green : null,
                ),
                onPressed: () => _toggleTodo(todo),
              ),
              title: Text(
                todo.title,
                style: TextStyle(
                  decoration: todo.isDone ? TextDecoration.lineThrough : null,
                  color: todo.isDone ? Colors.grey : null,
                ),
              ),
              subtitle: Text(todo.priority.label),
            ),
          );
        },
      ),
    );
  }

  void _showAddSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => AddTodoSheet(onAdd: _addTodo),
    );
  }
}

class AddTodoSheet extends StatefulWidget {
  final void Function(String, Priority) onAdd;
  const AddTodoSheet({super.key, required this.onAdd});

  @override
  State<AddTodoSheet> createState() => _AddTodoSheetState();
}

class _AddTodoSheetState extends State<AddTodoSheet> {
  final _controller = TextEditingController();
  Priority _priority = Priority.medium;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Task title'),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.trim().isEmpty) return;
                _addTodo(_controller.text.trim(), _priority);
                Navigator.pop(context);
              },
              child: const Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }

  void _addTodo(String title, Priority priority) {
    widget.onAdd(title, priority);
  }
}
