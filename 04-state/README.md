# 🔄 State Management

SwiftUI's state model is the most important thing to understand. Get this right and everything clicks.

| File | Topic |
|---|---|
| [property-wrappers.md](property-wrappers.md) | All 8 property wrappers — when to use each |
| [observable-pattern.md](observable-pattern.md) | `@Observable` vs `ChangeNotifier` deep dive |
| [data-flow.md](data-flow.md) | Data flow diagram — state ownership rules |

## The one-line summary

| Flutter | SwiftUI | Use when |
|---|---|---|
| local `setState` | `@State` | Local, private, simple values |
| callback `onChanged:` | `@Binding` | Parent owns state, child reads/writes |
| `ChangeNotifier` | `@Observable` | Shared model across multiple views |
| `InheritedWidget` / context | `@Environment` | System values or app-wide injection |
| `SharedPreferences` | `@AppStorage` | Persisted key-value |
