import SwiftUI

struct ProfileHeader: View {
    @Binding var isFollowing: Bool
    let onFollow: () -> Void

    var body: some View {
        ZStack(alignment: .bottom) {
            MeshGradient(
                width: 3, height: 3,
                points: [
                    [0, 0], [0.5, 0], [1, 0],
                    [0, 0.5], [0.4, 0.3], [1, 0.5],
                    [0, 1], [0.5, 1], [1, 1]
                ],
                colors: [
                    .blue, .purple, .indigo,
                    .cyan, .blue, .purple,
                    .teal, .cyan, .blue
                ]
            )
            .frame(height: 260)

            HStack(alignment: .bottom, spacing: 14) {
                AsyncImage(url: URL(string: "https://i.pravatar.cc/150?img=8")) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    Circle().fill(.secondary)
                }
                .frame(width: 72, height: 72)
                .clipShape(Circle())
                .overlay(Circle().stroke(.white.opacity(0.5), lineWidth: 2))

                VStack(alignment: .leading, spacing: 4) {
                    Text("Alex Chen").font(.title3.bold()).foregroundStyle(.white)
                    Text("@alexchen_dev").font(.subheadline).foregroundStyle(.white.opacity(0.75))
                }

                Spacer()

                GlassEffectContainer(spacing: 8) {
                    Button {
                        withAnimation(.spring(response: 0.3)) { onFollow() }
                    } label: {
                        Text(isFollowing ? "Following" : "Follow")
                            .font(.subheadline.bold())
                            .foregroundStyle(.white)
                    }

                    Button {
                        // message action
                    } label: {
                        Image(systemName: "bubble")
                            .foregroundStyle(.white)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
            .padding(.top, 80)
            .glassEffect(.regular.tint(.black.opacity(0.15)))
        }
    }
}
