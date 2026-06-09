# Data Flow in SwiftUI

> The rule: **state flows down, actions flow up.** Views never reach up to modify ancestor state directly — they either receive a `@Binding` or trigger an action on a shared model.

## Flow Diagram

```mermaid
graph TD
    APP[App Entry Point] -->|creates| MODEL["@Observable Model\nCartModel, UserSession..."]
    APP -->|.environment(model)| ROOT[Root View]

    ROOT -->|reads model directly| ROOT
    ROOT -->|@Binding '$value'| CHILD1[Child View]
    ROOT -->|@Binding '$value'| CHILD2[Child View]

    CHILD1 -->|mutates @Binding| ROOT
    CHILD2 -->|calls model.action()| MODEL
    MODEL -->|auto-notifies| ROOT
    MODEL -->|auto-notifies| CHILD2

    LEAF[Deep Nested View] -->|@Environment| MODEL
    LEAF -->|@Environment '\.dismiss'| DISMISS[Dismiss Action]

    style MODEL fill:#BF5AF215,stroke:#BF5AF2
    style APP fill:#FA734315,stroke:#FA7343
    style ROOT fill:#0A84FF15,stroke:#0A84FF
```

## Ownership Rules

```
1. @State       → owned by THIS view, private, not passed up
2. @Binding     → owned by a PARENT, child reads/writes through binding
3. @Observable  → owned by whoever created it (App/scene), accessed anywhere via @Environment
4. @Environment → read-only access to ancestor-provided values
```

## Anti-Patterns to Avoid

```swift
// ❌ Don't pass @State via binding unnecessarily deep
struct GrandparentView: View {
  @State private var isOn = false
  var body: some View {
    ParentView(isOn: $isOn)
  }
}
struct ParentView: View {
  @Binding var isOn: Bool
  var body: some View {
    ChildView(isOn: $isOn)  // prop-drilling — same as Flutter
  }
}

// ✅ Lift shared state into @Observable, inject via @Environment
@Observable class AppSettings {
  var isOn = false
}
// Then any view can: @Environment(AppSettings.self) var settings
```

## State vs Binding Decision Tree

```
Is this state only used in THIS view and its direct children?
  YES → @State + @Binding to children
  NO  → @Observable model + @Environment
  
Does the value need to persist across app launches?
  YES → @AppStorage (simple) or SwiftData (structured)
  NO  → @State or @Observable
  
Is it a system value (colorScheme, locale, dismiss)?
  YES → @Environment(\.keyPath)
```
