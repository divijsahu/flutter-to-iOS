import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \TodoItem.createdAt, order: .reverse)
    private var todos: [TodoItem]

    @State private var showAddSheet = false

    var pendingCount: Int { todos.filter { !$0.isDone }.count }

    var body: some View {
        NavigationStack {
            List {
                ForEach(todos) { todo in
                    TodoRow(todo: todo)
                }
                .onDelete(perform: delete)
                .onMove(perform: move)
            }
            .navigationTitle("Tasks")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddSheet = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Text(pendingCount == 0 ? "All done! 🎉" : "\(pendingCount) remaining")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .sheet(isPresented: $showAddSheet) {
                AddTodoSheet { title, priority in
                    context.insert(TodoItem(title: title, priority: priority))
                }
                .presentationDetents([.medium])
            }
        }
    }

    private func delete(at offsets: IndexSet) {
        offsets.map { todos[$0] }.forEach { context.delete($0) }
    }

    private func move(from source: IndexSet, to destination: Int) {
        // Add an `order: Int` property to TodoItem for production reordering
    }
}

struct AddTodoSheet: View {
    let onAdd: (String, TodoItem.Priority) -> Void
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var priority = TodoItem.Priority.medium

    var body: some View {
        NavigationStack {
            Form {
                TextField("Task title", text: $title)
                Picker("Priority", selection: $priority) {
                    ForEach(TodoItem.Priority.allCases, id: \.self) { p in
                        Text(p.label).tag(p)
                    }
                }
                .pickerStyle(.segmented)
            }
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                        onAdd(title, priority)
                        dismiss()
                    }
                    .fontWeight(.semibold)
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}
