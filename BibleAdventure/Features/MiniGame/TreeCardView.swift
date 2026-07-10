import SwiftUI

struct TreeCardView: View {

    let tree: Tree
    let isSelected: Bool
    let action: () -> Void

    var body: some View {

        Button(action: action) {

            VStack(spacing: 12) {

                Text(tree.emoji)
                    .font(.system(size: 60))

                Text(tree.name)
                    .font(.headline)

            }
            .frame(width: 110, height: 150)
            .background(
                isSelected
                ? Color.green.opacity(0.35)
                : Color.green.opacity(0.15)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        isSelected ? Color.green : Color.clear,
                        lineWidth: 3
                    )
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .scaleEffect(isSelected ? 1.08 : 1.0)
            .animation(.easeInOut(duration: 0.25), value: isSelected)

        }
        .buttonStyle(.plain)

    }

}
