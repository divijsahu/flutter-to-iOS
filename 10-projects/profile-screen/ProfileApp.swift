import SwiftUI

@main
struct ProfileApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                Tab("Profile", systemImage: "person.fill") {
                    ProfileView()
                }
                Tab("Feed", systemImage: "rectangle.stack.fill") {
                    Text("Feed").font(.largeTitle)
                }
                Tab("Messages", systemImage: "bubble.fill") {
                    Text("Messages").font(.largeTitle)
                }
            }
        }
    }
}
