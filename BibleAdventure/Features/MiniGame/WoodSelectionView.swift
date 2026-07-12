import SwiftUI

struct WoodSelectionView: View {

    let onComplete: () -> Void

    private let woodPieces: [WoodPiece] = [

        WoodPiece(
            id: "oak",
            name: "Oak Wood",
            style: .oak,
            isCorrect: false
        ),

        WoodPiece(
            id: "cedar",
            name: "Cedar Wood",
            style: .cedar,
            isCorrect: false
        ),

        WoodPiece(
            id: "cypress1",
            name: "Cypress Wood",
            style: .cypress,
            isCorrect: true
        ),

        WoodPiece(
            id: "pine",
            name: "Pine Wood",
            style: .pine,
            isCorrect: false
        ),

        WoodPiece(
            id: "cypress2",
            name: "Cypress Wood",
            style: .cypress,
            isCorrect: true
        ),

        WoodPiece(
            id: "cypress3",
            name: "Cypress Wood",
            style: .cypress,
            isCorrect: true
        )
    ]

    @State private var availableWood: [WoodPiece] = []

    @State private var collectedWoodIDs: Set<String> = []
    @State private var dragOffsets: [String: CGSize] = [:]

    @State private var dropZoneFrame: CGRect?
    @State private var activeWoodID: String?

    @State private var feedback =
        "Find the cypress wood and drag it to Noah."

    @State private var completed = false

    private var requiredWoodCount: Int {
        woodPieces.filter(\.isCorrect).count
    }

    var body: some View {

        ScrollView {

            VStack(spacing: 24) {

                headerView

                progressView

                forestScene

                if completed {

                    completedView

                } else {

                    woodTray

                }

            }
            .padding()

        }
        .onAppear {
            prepareWood()
        }

    }

    // MARK: - Header

    private var headerView: some View {

        VStack(spacing: 8) {

            Text("🌲 Find Cypress Wood")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)

            Text(
                "GOD told Noah to make the ark from cypress wood."
            )
            .multilineTextAlignment(.center)

            Text("📖 Genesis 6:14")
                .font(.caption)
                .foregroundStyle(.secondary)

        }

    }

    // MARK: - Progress

    private var progressView: some View {

        VStack(spacing: 10) {

            ProgressView(
                value: Double(collectedWoodIDs.count),
                total: Double(requiredWoodCount)
            )

            Text(
                "\(collectedWoodIDs.count) of \(requiredWoodCount) cypress wood collected"
            )
            .font(.caption)
            .foregroundStyle(.secondary)

            Text(feedback)
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundStyle(
                    feedback.hasPrefix("✨")
                    ? Color.green
                    : Color.primary
                )

        }

    }

    // MARK: - Forest Scene

    private var forestScene: some View {

        ZStack {

            RoundedRectangle(cornerRadius: 24)
                .fill(Color.green.opacity(0.12))

            VStack {

                HStack {

                    Text("🌲")
                        .font(.system(size: 75))

                    Spacer()

                    Text("🌳")
                        .font(.system(size: 80))

                    Spacer()

                    Text("🌲")
                        .font(.system(size: 70))

                }

                Spacer()

                HStack(spacing: 24) {

                    Text("👨🏻")
                        .font(.system(size: 70))

                    dropZone

                }

            }
            .padding()

        }
        .frame(height: 300)
        .overlay {

            RoundedRectangle(cornerRadius: 24)
                .stroke(
                    Color.green.opacity(0.3),
                    lineWidth: 2
                )

        }

    }

    // MARK: - Drop Zone

    private var dropZone: some View {

        ZStack {

            RoundedRectangle(cornerRadius: 18)
                .fill(Color.brown.opacity(0.12))

            RoundedRectangle(cornerRadius: 18)
                .stroke(
                    activeWoodID == nil
                    ? Color.brown.opacity(0.4)
                    : Color.orange,
                    style: StrokeStyle(
                        lineWidth: 3,
                        dash: [8]
                    )
                )

            VStack(spacing: 8) {

                if collectedWoodIDs.isEmpty {

                    Image(
                        systemName: "arrow.down.circle.fill"
                    )
                    .font(.largeTitle)

                    Text("DROP WOOD HERE")
                        .font(.caption)
                        .bold()

                } else {

                    ZStack {

                        ForEach(
                            Array(collectedWoodIDs.enumerated()),
                            id: \.element
                        ) { index, _ in

                            WoodBlockView(
                                style: .cypress
                            )
                            .scaleEffect(0.5)
                            .offset(
                                x: CGFloat(index * 8),
                                y: CGFloat(index * -8)
                            )
                        }

                    }

                    Text("CYPRESS WOOD")
                        .font(.caption)
                        .bold()

                }

            }
            .foregroundStyle(.brown)

        }
        .frame(
            width: 160,
            height: 150
        )
        .background {

            GeometryReader { geometry in

                Color.clear
                    .onAppear {

                        dropZoneFrame = geometry.frame(
                            in: .global
                        )

                    }
                    .onChange(
                        of: geometry.frame(in: .global)
                    ) { _, newFrame in

                        dropZoneFrame = newFrame

                    }

            }

        }

    }

    // MARK: - Wood Tray

    private var woodTray: some View {

        VStack(spacing: 16) {

            Text("🪵 Forest Wood")
                .font(.title2)
                .bold()

            Text(
                "Drag the correct wood to Noah."
            )
            .font(.caption)
            .foregroundStyle(.secondary)

            LazyVGrid(
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],
                spacing: 16
            ) {

                ForEach(availableWood) { wood in

                    if !collectedWoodIDs.contains(wood.id) {

                        draggableWood(wood)

                    }

                }

            }

        }

    }

    // MARK: - Draggable Wood

    private func draggableWood(
        _ wood: WoodPiece
    ) -> some View {

        VStack(spacing: 8) {

          WoodBlockView(
            style: wood.style
        )

            Text(wood.name)
                .font(.headline)

        }
        .frame(maxWidth: .infinity)
        .frame(height: 120)
        .background(
            Color.brown.opacity(0.1)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 16)
        )
        .overlay {

            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    activeWoodID == wood.id
                    ? Color.orange
                    : Color.clear,
                    lineWidth: 3
                )

        }
        .offset(
            dragOffsets[wood.id] ?? .zero
        )
        .zIndex(
            activeWoodID == wood.id
            ? 10
            : 0
        )
        .gesture(

            DragGesture(
                coordinateSpace: .global
            )
            .onChanged { value in

                activeWoodID = wood.id

                dragOffsets[wood.id] =
                    value.translation

                feedback =
                    "Bring \(wood.name) to Noah."

            }
            .onEnded { value in

                handleDrop(
                    wood: wood,
                    location: value.location
                )

            }

        )

    }

    // MARK: - Drop Logic

    private func handleDrop(
        wood: WoodPiece,
        location: CGPoint
    ) {

        guard let dropZoneFrame else {

            resetWood(wood)
            return

        }

        let expandedFrame = dropZoneFrame.insetBy(
            dx: -50,
            dy: -50
        )

        guard expandedFrame.contains(location) else {

            resetWood(wood)
            return

        }

        if wood.isCorrect {

            collectWood(wood)

        } else {

            rejectWood(wood)

        }

    }

    // MARK: - Correct Wood

    private func collectWood(
        _ wood: WoodPiece
    ) {

        withAnimation(
            .spring(
                response: 0.4,
                dampingFraction: 0.65
            )
        ) {

            collectedWoodIDs.insert(wood.id)

            dragOffsets[wood.id] = .zero
            activeWoodID = nil

        }

        feedback =
            "✨ Correct! Noah needs cypress wood."

        checkCompletion()

    }

    // MARK: - Wrong Wood

    private func rejectWood(
        _ wood: WoodPiece
    ) {

        feedback =
            "\(wood.name) is not the wood GOD told Noah to use."

        withAnimation(
            .spring(
                response: 0.4,
                dampingFraction: 0.6
            )
        ) {

            dragOffsets[wood.id] = .zero
            activeWoodID = nil

        }

    }

    // MARK: - Reset

    private func resetWood(
        _ wood: WoodPiece
    ) {

        withAnimation(
            .spring(
                response: 0.4,
                dampingFraction: 0.7
            )
        ) {

            dragOffsets[wood.id] = .zero
            activeWoodID = nil

        }

        feedback =
            "Try again. Drag the wood to Noah."

    }

    // MARK: - Completion

    private func checkCompletion() {

        guard
            collectedWoodIDs.count
                == requiredWoodCount
        else {
            return
        }

        DispatchQueue.main.asyncAfter(
            deadline: .now() + 0.7
        ) {

            withAnimation(.easeInOut) {

                completed = true

                feedback =
                    "🎉 Noah collected the cypress wood!"

            }

        }

    }

    private var completedView: some View {

        VStack(spacing: 20) {

            Text("🪵🪵🪵")
                .font(.system(size: 55))

            Text("Cypress Wood Collected!")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)

            Text(
                "Noah now had the wood needed to begin building the ark."
            )
            .font(.title3)
            .multilineTextAlignment(.center)

            Text("📖 Genesis 6:14")
                .font(.headline)
                .foregroundStyle(.secondary)

            Button("Continue Story") {

                onComplete()

            }
            .buttonStyle(.borderedProminent)

        }

    }

    // MARK: - Setup

    private func prepareWood() {

        guard availableWood.isEmpty else {
            return
        }

        availableWood = woodPieces.shuffled()

    }

}

// MARK: - Wood Piece

struct WoodPiece: Identifiable {

    let id: String
    let name: String
    let style: WoodStyle
    let isCorrect: Bool
}

enum WoodStyle {
    case oak
    case cedar
    case cypress
    case pine
}

#Preview {

    WoodSelectionView(
        onComplete: {}
    )

}
