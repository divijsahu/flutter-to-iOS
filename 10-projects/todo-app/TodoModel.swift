import SwiftData
import Foundation

@Model
final class TodoItem {
    var title: String
    var isDone: Bool
    var createdAt: Date
    var priority: Priority

    enum Priority: Int, Codable, CaseIterable {
        case low = 0, medium = 1, high = 2
        var label: String { ["Low", "Medium", "High"][rawValue] }
        var color: String { ["blue", "orange", "red"][rawValue] }
    }

    init(title: String, priority: Priority = .medium) {
        self.title = title
        self.isDone = false
        self.createdAt = Date()
        self.priority = priority
    }
}
