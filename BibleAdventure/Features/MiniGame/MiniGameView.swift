import SwiftUI

struct MiniGameView: View {

    let miniGame: MiniGameType
    let matchingPresentation: PairMatchingPresentation?
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
           
        case .gatherAnimals, .gatherProvisions:
            if let matchingPresentation {
                PairMatchingView(configuration: matchingPresentation, onComplete: onComplete)
            } else {
                Text("This matching activity is unavailable.")
            }
            
        case .enterArk:

            EnterArkView(
                onComplete: onComplete
            )
            
        case .floodJourney:

            FloodJourneyView(
                onComplete: onComplete
            )
        
        case .sendDove:

            SendDoveView(
                onComplete: onComplete
            )
        
        case .buildRainbow:

            BuildRainbowView(
                onComplete: onComplete
            )
        
        case .rainbowCovenant:

            RainbowCovenantView(
                onComplete: onComplete
            )
        }
    }
}

#Preview {

    MiniGameView(
        miniGame: .woodSelection,
        matchingPresentation: nil,
        onComplete: {}
    )

}
