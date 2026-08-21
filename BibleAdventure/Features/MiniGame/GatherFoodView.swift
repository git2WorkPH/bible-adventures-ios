import SwiftUI

struct GatherFoodView: View {

    let onComplete: () -> Void

    private let foodSupplies: [FoodSupply] = [
        FoodSupply(
            id: "apple",
            name: "Apples",
            emoji: "🍎"
        ),
        FoodSupply(
            id: "bread",
            name: "Bread",
            emoji: "🍞"
        ),
        FoodSupply(
            id: "grain",
            name: "Grain",
            emoji: "🌾"
        ),
        FoodSupply(
            id: "carrot",
            name: "Carrots",
            emoji: "🥕"
        ),
        FoodSupply(
            id: "grapes",
            name: "Grapes",
            emoji: "🍇"
        ),
        FoodSupply(
            id: "corn",
            name: "Corn",
            emoji: "🌽"
        )
    ]

    @State private var availableFood: [FoodSupply] = []
    @State private var collectedFood: [FoodSupply] = []
    @State private var completed = false

    var body: some View {

        VStack(spacing: 24) {

            Text("🍎 Gather Food")
                .font(.largeTitle)
                .bold()

            Text(
                "Help Noah gather food for his family and the animals."
            )
            .multilineTextAlignment(.center)

            progressView

            Spacer()

            if completed {

                completedView

            } else {

                foodCollectionView

            }

            Spacer()

        }
        .padding()
        .onAppear {

            prepareFood()

        }
    }

    // MARK: - Progress

    private var progressView: some View {

        VStack(spacing: 12) {

            Text("Food Collected")
                .font(.headline)

            ProgressView(
                value: Double(collectedFood.count),
                total: Double(foodSupplies.count)
            )

            Text(
                "\(collectedFood.count) of \(foodSupplies.count)"
            )
            .font(.caption)
            .foregroundStyle(.secondary)

            HStack {

                ForEach(collectedFood) { food in

                    Text(food.emoji)
                        .font(.title)

                }

            }

        }

    }

    // MARK: - Food Collection

    private var foodCollectionView: some View {

        VStack(spacing: 20) {

            Text("Tap food to collect it")
                .font(.title2)
                .bold()

            LazyVGrid(
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],
                spacing: 16
            ) {

                ForEach(availableFood) { food in

                    Button {

                        collect(food)

                    } label: {

                        VStack(spacing: 8) {

                            Text(food.emoji)
                                .font(.system(size: 55))

                            Text(food.name)
                                .font(.headline)

                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 120)
                        .background(
                            Color.orange.opacity(0.1)
                        )
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 16
                            )
                        )

                    }
                    .buttonStyle(.plain)

                }

            }

        }

    }

    // MARK: - Completed

    private var completedView: some View {

        VStack(spacing: 20) {

            Text("🎉")
                .font(.system(size: 70))

            Text("Food Collected!")
                .font(.largeTitle)
                .bold()

            Text(
                "You helped Noah gather food for everyone on the ark."
            )
            .multilineTextAlignment(.center)

            HStack {

                ForEach(collectedFood) { food in

                    Text(food.emoji)
                        .font(.largeTitle)

                }

            }

            Text("📖 Genesis 6:21")
                .font(.caption)
                .foregroundStyle(.secondary)

            Button("Continue Story") {

                onComplete()

            }
            .buttonStyle(.borderedProminent)

        }

    }

    // MARK: - Logic

    private func prepareFood() {

        availableFood = foodSupplies.shuffled()

    }

    private func collect(
        _ food: FoodSupply
    ) {

        withAnimation(.easeInOut) {

            collectedFood.append(food)

            availableFood.removeAll {
                $0.id == food.id
            }

            availableFood.shuffle()

        }

        if collectedFood.count == foodSupplies.count {

            withAnimation {

                completed = true

            }

        }

    }

}

#Preview {

    GatherFoodView(
        onComplete: {}
    )

}
