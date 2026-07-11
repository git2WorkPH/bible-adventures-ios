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
            
        case .buildArk:

            BuildArkView(
                onComplete: onComplete
            )

        case .gatherFood:

            GatherFoodView(
                onComplete: onComplete
            )
           
        case .gatherAnimals:

            GatherAnimalsView(
                onComplete: onComplete
            )
        }

    }
}

#Preview {

    MiniGameView(
        miniGame: .woodSelection,
        onComplete: {}
    )

}
