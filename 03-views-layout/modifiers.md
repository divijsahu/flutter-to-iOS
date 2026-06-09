# View Modifiers

> **This is the #1 mindset shift from Flutter to SwiftUI. Read carefully.**

## Flutter wraps. SwiftUI chains.

```dart
// Flutter — every decoration is a wrapper widget, building inside-out
Padding(
  padding: const EdgeInsets.all(16),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Container(
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Text('Click me', style: TextStyle(color: Colors.white)),
      ),
    ),
  ),
)
```

```swift
// SwiftUI — chain modifiers, read top-to-bottom
Text("Click me")
  .foregroundStyle(.white)
  .padding(.horizontal, 24)
  .padding(.vertical, 12)
  .background(.blue)
  .cornerRadius(12)
  .padding(16)
```

## ⚠️ Order Matters

This is the most common mistake Flutter devs make in SwiftUI. **Modifiers apply sequentially, wrapping the result of the previous modifier.**

```swift
// WRONG — background is only behind the text, then padding is outside
Text("Hello")
  .background(.red)
  .padding(16)
// Result: red box tight around text, 16pt transparent space outside

// RIGHT — padding first, then background covers the padded area
Text("Hello")
  .padding(16)
  .background(.red)
// Result: red box with 16pt padding inside
```

```swift
// cornerRadius before vs after background — same issue
Text("Hello")
  .padding()
  .background(.blue)
  .cornerRadius(10)       // clips the background ✓

Text("Hello")
  .cornerRadius(10)       // clips nothing (no background yet)
  .padding()
  .background(.blue)      // square blue box, unclipped ✗
```

## Essential Modifiers Reference

```swift
Text("Hello")
  // Typography
  .font(.title)                         // semantic size
  .font(.system(size: 18, weight: .semibold))
  .fontWeight(.bold)
  .foregroundStyle(.primary)            // adaptive text color
  .foregroundStyle(Color.blue)
  .multilineTextAlignment(.center)
  .lineLimit(2)
  .truncationMode(.tail)

  // Spacing & Size
  .padding()                            // all sides, system default (16)
  .padding(24)                          // all sides, custom
  .padding(.horizontal, 24)            // horizontal only
  .padding(.top, 8)                     // single edge
  .frame(width: 200, height: 50)       // fixed size
  .frame(maxWidth: .infinity)          // fill width
  .frame(minHeight: 44)                // minimum height

  // Background & Border
  .background(.blue)
  .background(.ultraThinMaterial)       // glassmorphism material
  .background(LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom))
  .overlay(RoundedRectangle(cornerRadius: 8).stroke(.blue, lineWidth: 1))
  .border(.gray, width: 1)

  // Shape & Clipping
  .cornerRadius(12)
  .clipShape(RoundedRectangle(cornerRadius: 12))
  .clipShape(Circle())
  .clipShape(Capsule())

  // Shadow & Elevation
  .shadow(radius: 8)
  .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 4)

  // Visibility & Opacity
  .opacity(0.5)
  .hidden()
  .opacity(isVisible ? 1 : 0)         // conditional visibility (keeps layout space)

  // Gestures
  .onTapGesture { print("tapped") }
  .onLongPressGesture { print("held") }
```
