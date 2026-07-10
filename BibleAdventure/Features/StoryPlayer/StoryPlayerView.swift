import SwiftUI

struct StoryPlayerView: View {

    let story = StoryRepository.loadStory(.noah)

    @State private var currentStep = 0
    @State
    private var isCompleted = false

    var body: some View {

        NavigationStack {

            VStack {
                
                Spacer()

                if isCompleted {

                       StoryCompleteView(
                           title: story.title
                       )

                } else {
                    
                    switch story.steps[currentStep] {
                        
                    case .dialogue(let page):
                        
                        DialogueView(
                            page: page,
                            onContinue: nextStep
                        )
                        
                    case .objective(let objective):
                        
                        ObjectiveView(
                            objective: objective,
                            onComplete: nextStep
                        )
                        
                    case .miniGame(let miniGame):
                        
                        MiniGameView(
                            miniGame: miniGame,
                            onComplete: nextStep
                        )
                        
                    }
                }
                Spacer()

               
            }
            .padding()

        }
    }
    
//    private func nextStep() {
//
//        guard currentStep < story.steps.count - 1 else {
//            return
//        }
//
//        currentStep += 1
//    }
    
    private func nextStep() {

        if currentStep < story.steps.count - 1 {
            print("Moving from step \(currentStep)")

            currentStep += 1

        } else {

            isCompleted = true

        }

    }
}

#Preview {
    StoryPlayerView()
}
