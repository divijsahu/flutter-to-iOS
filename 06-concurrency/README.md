# ⚡ Concurrency

Swift's concurrency model is similar to Dart's in syntax but more powerful in guarantees. The key addition is `Actor` — Swift's answer to Dart's `Isolate`, but with shared memory and type-safe access.

| File | Topic |
|---|---|
| [async-await.md](async-await.md) | async/await, throws, task modifier, parallel async |
| [actors.md](actors.md) | Actors, @MainActor, structured concurrency |

> **The key win over Flutter:** `async let` lets you fire multiple async operations in parallel with two lines of code. No `Future.wait`, no stream gymnastics.
