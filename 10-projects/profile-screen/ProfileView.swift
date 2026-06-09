import SwiftUI

struct ProfileView: View {
    @State private var isFollowing = false

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ProfileHeader(
                    isFollowing: $isFollowing,
                    onFollow: { isFollowing.toggle() }
                )
                statsRow
                bioSection
            }
        }
        .ignoresSafeArea(edges: .top)
    }

    private var statsRow: some View {
        HStack(spacing: 0) {
            ForEach(
                [("256", "Posts"), ("14.2K", "Followers"), ("891", "Following")],
                id: \.0
            ) { count, label in
                VStack(spacing: 2) {
                    Text(count).font(.title3.bold())
                    Text(label).font(.caption).foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical, 16)
        .background(.background.opacity(0.95))
    }

    private var bioSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Flutter dev turned iOS engineer. Building native apps that Liquid Glass can't reach.")
                .font(.subheadline)

            Label("San Francisco, CA", systemImage: "mappin")
                .font(.caption)
                .foregroundStyle(.secondary)

            Label("github.com/flutter-to-ios", systemImage: "link")
                .font(.caption)
                .foregroundStyle(.blue)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
    }
}
