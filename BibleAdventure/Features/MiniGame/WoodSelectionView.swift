import SwiftUI

struct WoodSelectionView: View {

    let onComplete: () -> Void

    @State private var feedback = ""
    @State private var hasAnswered = false
    @State private var isCorrect = false
    @State private var selectedTree: Tree?
    
    private let trees = [

        Tree(name: "Oak", emoji: "🌳", isCorrect: false),

        Tree(name: "Cypress", emoji: "🌲", isCorrect: true),

        Tree(name: "Palm", emoji: "🌴", isCorrect: false)

    ]

    var body: some View {

        VStack(spacing: 24) {

            Spacer()

            Text("🌲 Find the Correct Wood")
                .font(.largeTitle)
                .bold()

            Text("""
Choose the wood GOD instructed Noah to use.
""")
            .multilineTextAlignment(.center)

            HStack(spacing: 20) {

                ForEach(trees) { tree in

                    TreeCardView(
                        tree: tree,
                        isSelected: selectedTree?.id == tree.id
                    ) {

                        choose(tree)

                    }

                }

            }

            if hasAnswered {

                Text(feedback)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

            }

            if isCorrect {

                Button("Continue") {

                    onComplete()

                }
                .buttonStyle(.borderedProminent)

            }

            Spacer()

        }
        .padding()

    }

    private func choose(_ tree: Tree) {

        selectedTree = tree

        hasAnswered = true

        if tree.isCorrect {

            isCorrect = true

            feedback = """
    ✅ Excellent!

    You remembered that GOD instructed Noah to use cypress wood.
    """

        } else {

            isCorrect = false

            feedback = """
    ❌ That's not the correct wood.

    Read Genesis 6:14 and try again.
    """

        }

    }

}

#Preview {

    WoodSelectionView(
        onComplete: {}
    )

}
