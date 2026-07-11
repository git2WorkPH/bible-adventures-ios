import SwiftUI

struct GatherAnimalsView: View {

    let onComplete: () -> Void

    private let animals: [AnimalPair] = [

        AnimalPair(
            id: "lion",
            name: "Lion",
            emoji: "🦁"
        ),

        AnimalPair(
            id: "elephant",
            name: "Elephant",
            emoji: "🐘"
        ),

        AnimalPair(
            id: "giraffe",
            name: "Giraffe",
            emoji: "🦒"
        ),

        AnimalPair(
            id: "zebra",
            name: "Zebra",
            emoji: "🦓"
        ),
    
        AnimalPair(id:"tiger", name: "Tiger", emoji: "🐅"),
        AnimalPair(id: "parrot", name: "Parrot", emoji: "🦜"),
        AnimalPair(id:"redFireAnt", name:"Red Fire Ant", emoji: "🐜"),
        AnimalPair(id:"spider", name:"Spider", emoji: "🕷️")
        
        
    ]

    @State private var animalCards: [AnimalCard] = []

    @State private var selectedCard: AnimalCard?

    @State private var matchedAnimalIDs: Set<String> = []

    @State private var feedback = ""

    @State private var completed = false

    @State private var isCheckingPair = false

    var body: some View {

        ScrollView {

            VStack(spacing: 24) {

                Text("🦒 Gather the Animals")
                    .font(.largeTitle)
                    .bold()

                Text(
                    "Help Noah find the matching animal pairs."
                )
                .multilineTextAlignment(.center)

                progressView

                if completed {

                    completedView

                } else {

                    animalGrid

                }

            }
            .padding()

        }
        .onAppear {

            prepareAnimals()

        }
    }

    // MARK: - Progress

    private var progressView: some View {

        VStack(spacing: 12) {

            Text("Animal Pairs Gathered")
                .font(.headline)

            ProgressView(
                value: Double(matchedAnimalIDs.count),
                total: Double(animals.count)
            )

            Text(
                "\(matchedAnimalIDs.count) of \(animals.count)"
            )
            .font(.caption)
            .foregroundStyle(.secondary)

            HStack(spacing: 12) {

                ForEach(animals) { animal in

                    if matchedAnimalIDs.contains(animal.id) {

                        Text("\(animal.emoji)\(animal.emoji)")
                            .font(.title2)

                    }

                }

            }

        }

    }

    // MARK: - Animal Grid

    private var animalGrid: some View {

        VStack(spacing: 20) {

            Text("Find the matching pairs")
                .font(.title2)
                .bold()

            LazyVGrid(
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],
                spacing: 16
            ) {

                ForEach(animalCards) { card in

                    animalCard(card)

                }

            }

            if !feedback.isEmpty {

                Text(feedback)
                    .font(.headline)
                    .multilineTextAlignment(.center)

            }

        }

    }

    // MARK: - Animal Card

    private func animalCard(
        _ card: AnimalCard
    ) -> some View {

        let isSelected = selectedCard?.id == card.id

        return Button {

            select(card)

        } label: {

            VStack(spacing: 8) {

                Text(card.emoji)
                    .font(.system(size: 60))

                Text(card.name)
                    .font(.headline)

            }
            .frame(maxWidth: .infinity)
            .frame(height: 130)
            .background {

                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        isSelected
                        ? Color.blue.opacity(0.25)
                        : Color.green.opacity(0.1)
                    )

            }
            .overlay {

                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        isSelected
                        ? Color.blue
                        : Color.clear,
                        lineWidth: 3
                    )

            }

        }
        .buttonStyle(.plain)
        .disabled(isCheckingPair)
    }

    // MARK: - Completed

    private var completedView: some View {

        VStack(spacing: 20) {

            Text("🚢")
                .font(.system(size: 70))

            Text("Animals Gathered!")
                .font(.largeTitle)
                .bold()

            Text(
                "You helped Noah gather the animal pairs."
            )
            .multilineTextAlignment(.center)

            VStack(spacing: 12) {

                ForEach(animals) { animal in

                    Text(
                        "\(animal.emoji) \(animal.emoji)  \(animal.name) Pair"
                    )
                    .font(.title3)

                }

            }

            Text("📖 Genesis 7")
                .font(.caption)
                .foregroundStyle(.secondary)

            Button("Continue Story") {

                onComplete()

            }
            .buttonStyle(.borderedProminent)

        }

    }

    // MARK: - Logic

    private func prepareAnimals() {

        animalCards = animals
            .flatMap { animal in

                [
                    AnimalCard(
                        animalID: animal.id,
                        name: animal.name,
                        emoji: animal.emoji
                    ),

                    AnimalCard(
                        animalID: animal.id,
                        name: animal.name,
                        emoji: animal.emoji
                    )
                ]

            }
            .shuffled()

    }

    private func select(
        _ card: AnimalCard
    ) {

        guard !isCheckingPair else {
            return
        }

        if selectedCard?.id == card.id {

            selectedCard = nil
            feedback = ""

            return
        }

        guard let firstCard = selectedCard else {

            selectedCard = card
            feedback = "Find the matching \(card.name)."

            return
        }

        isCheckingPair = true

        if firstCard.animalID == card.animalID {

            matchedAnimalIDs.insert(card.animalID)

            feedback = "✅ \(card.name) pair gathered!"

            withAnimation(.easeInOut) {

                animalCards.removeAll {
                    $0.animalID == card.animalID
                }

            }

            selectedCard = nil
            isCheckingPair = false

            checkCompletion()

        } else {

            feedback = "❌ Those animals don't match."

            DispatchQueue.main.asyncAfter(
                deadline: .now() + 0.8
            ) {

                selectedCard = nil
                feedback = ""
                isCheckingPair = false

            }

        }

    }

    private func checkCompletion() {

        if matchedAnimalIDs.count == animals.count {

            DispatchQueue.main.asyncAfter(
                deadline: .now() + 0.5
            ) {

                withAnimation {

                    completed = true

                }

            }

        }

    }

}

#Preview {

    GatherAnimalsView(
        onComplete: {}
    )

}
