import SwiftUI

struct MiniGameView: View {

    let miniGame: MiniGameType
    let onComplete: () -> Void

    var body: some View {

        switch miniGame {

        case .woodSelection:
            WoodSelectionView(onComplete: onComplete)

        case .measureArk:
            MeasureArkView(
                  onComplete: onComplete
              )

        case .animalCollection:
            PlaceholderMiniGameView(title: "Animal Collection")

        }

    }
}

#Preview {

    MiniGameView(
        miniGame: .woodSelection,
        onComplete: {}
    )

}
