import SwiftUI

struct BuildArkView: View {

    let onComplete: () -> Void

    private let snapDistance: CGFloat = 90

    private let arkPieces: [ArkPiece] = [
        ArkPiece(
            id: "base",
            name: "Ark Base",
            emoji: "🪵",
            targetPosition: CGPoint(x: 0.50, y: 0.78),
            size: CGSize(width: 250, height: 45)
        ),
        ArkPiece(
            id: "leftWall",
            name: "Left Wall",
            emoji: "🧱",
            targetPosition: CGPoint(x: 0.28, y: 0.58),
            size: CGSize(width: 55, height: 120)
        ),
        ArkPiece(
            id: "rightWall",
            name: "Right Wall",
            emoji: "🧱",
            targetPosition: CGPoint(x: 0.72, y: 0.58),
            size: CGSize(width: 55, height: 120)
        ),
        ArkPiece(
            id: "middleDeck",
            name: "Middle Deck",
            emoji: "🪵",
            targetPosition: CGPoint(x: 0.50, y: 0.58),
            size: CGSize(width: 170, height: 35)
        ),
        ArkPiece(
            id: "upperDeck",
            name: "Upper Deck",
            emoji: "🪵",
            targetPosition: CGPoint(x: 0.50, y: 0.42),
            size: CGSize(width: 145, height: 35)
        ),
        ArkPiece(
            id: "roof",
            name: "Ark Roof",
            emoji: "🏠",
            targetPosition: CGPoint(x: 0.50, y: 0.25),
            size: CGSize(width: 180, height: 55)
        )
    ]

    @State private var placedPieceIDs: Set<String> = []
    @State private var dragOffsets: [String: CGSize] = [:]
    @State private var completed = false
    @State private var feedback = "Drag a piece onto the blueprint."
    @State private var activePieceID: String?

    var body: some View {

        ScrollView {

            VStack(spacing: 24) {

                Text("🧱 Build the Ark")
                    .font(.largeTitle)
                    .bold()

                Text(
                    "Drag the wooden pieces onto the blueprint and build Noah's ark."
                )
                .multilineTextAlignment(.center)

                progressView

                arkBlueprint

                if completed {

                    completedView

                } else {

                    constructionTray

                }

            }
            .padding()

        }
    }

    // MARK: - Progress

    private var progressView: some View {

        VStack(spacing: 10) {

            ProgressView(
                value: Double(placedPieceIDs.count),
                total: Double(arkPieces.count)
            )

            Text(
                "\(placedPieceIDs.count) of \(arkPieces.count) pieces placed"
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

    // MARK: - Blueprint

    private var arkBlueprint: some View {

        GeometryReader { geometry in

            ZStack {

                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.blue.opacity(0.08))

                blueprintGrid

                Text("ARK BLUEPRINT")
                    .font(.caption)
                    .bold()
                    .foregroundStyle(.blue.opacity(0.5))
                    .position(
                        x: geometry.size.width / 2,
                        y: 22
                    )

                ForEach(arkPieces) { piece in

                    blueprintTarget(
                        for: piece,
                        geometry: geometry
                    )

                }

                ForEach(arkPieces) { piece in

                    if placedPieceIDs.contains(piece.id) {

                        placedArkPiece(
                            piece,
                            geometry: geometry
                        )

                    }

                }

            }
            .clipShape(
                RoundedRectangle(cornerRadius: 24)
            )
            .overlay {

                RoundedRectangle(cornerRadius: 24)
                    .stroke(
                        Color.blue.opacity(0.35),
                        lineWidth: 2
                    )

            }

        }
        .frame(height: 420)
        .background {

            GeometryReader { geometry in

                Color.clear
                    .onAppear {

                        blueprintFrame = geometry.frame(
                            in: .global
                        )

                    }
                    .onChange(
                        of: geometry.frame(in: .global)
                    ) { _, newFrame in

                        blueprintFrame = newFrame

                    }

            }

        }

    }

    private var blueprintGrid: some View {

        Canvas { context, size in

            let spacing: CGFloat = 25

            var path = Path()

            var x: CGFloat = 0

            while x <= size.width {

                path.move(
                    to: CGPoint(x: x, y: 0)
                )

                path.addLine(
                    to: CGPoint(
                        x: x,
                        y: size.height
                    )
                )

                x += spacing

            }

            var y: CGFloat = 0

            while y <= size.height {

                path.move(
                    to: CGPoint(x: 0, y: y)
                )

                path.addLine(
                    to: CGPoint(
                        x: size.width,
                        y: y
                    )
                )

                y += spacing

            }

            context.stroke(
                path,
                with: .color(
                    Color.blue.opacity(0.08)
                ),
                lineWidth: 1
            )

        }

    }

    // MARK: - Blueprint Target

    private func blueprintTarget(
        for piece: ArkPiece,
        geometry: GeometryProxy
    ) -> some View {

        let position = targetPosition(
            for: piece,
            geometry: geometry
        )

        return RoundedRectangle(cornerRadius: 8)
            .stroke(
                Color.blue.opacity(
                    activePieceID == piece.id
                    ? 0.8
                    : 0.3
                ),
                style: StrokeStyle(
                    lineWidth: activePieceID == piece.id
                    ? 3
                    : 2,
                    dash: [8]
                )
            )
            .frame(
                width: piece.size.width,
                height: piece.size.height
            )
            .position(position)
            .opacity(
                placedPieceIDs.contains(piece.id)
                ? 0
                : 1
            )

    }

    // MARK: - Placed Piece

    private func placedArkPiece(
        _ piece: ArkPiece,
        geometry: GeometryProxy
    ) -> some View {

        let position = targetPosition(
            for: piece,
            geometry: geometry
        )

        return pieceShape(piece)
            .position(position)
            .transition(
                .scale.combined(
                    with: .opacity
                )
            )

    }

    // MARK: - Construction Tray

    private var constructionTray: some View {

        VStack(spacing: 16) {

            Text("🪵 Construction Pieces")
                .font(.title2)
                .bold()

            Text("Drag each piece to its matching shape.")
                .font(.caption)
                .foregroundStyle(.secondary)

            LazyVGrid(
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],
                spacing: 16
            ) {

                ForEach(arkPieces) { piece in

                    if !placedPieceIDs.contains(piece.id) {

                        draggablePiece(piece)

                    }

                }

            }

        }

    }

    // MARK: - Draggable Piece

    private func draggablePiece(
        _ piece: ArkPiece
    ) -> some View {

        VStack(spacing: 8) {

            Text(piece.emoji)
                .font(.system(size: 35))

            Text(piece.name)
                .font(.headline)

            miniPieceShape(piece)

        }
        .frame(maxWidth: .infinity)
        .frame(height: 130)
        .background(
            Color.brown.opacity(0.12)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 16)
        )
        .overlay {

            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    activePieceID == piece.id
                    ? Color.orange
                    : Color.clear,
                    lineWidth: 3
                )

        }
        .offset(
            dragOffsets[piece.id] ?? .zero
        )
        .zIndex(
            activePieceID == piece.id
            ? 10
            : 0
        )
        .gesture(

            DragGesture(
                coordinateSpace: .global
            )
            .onChanged { value in

                activePieceID = piece.id

                dragOffsets[piece.id] =
                    value.translation

                feedback =
                    "Move \(piece.name) to the blueprint."

            }
            .onEnded { value in

                handleDrop(
                    piece: piece,
                    location: value.location
                )

            }

        )

    }

    // MARK: - Piece Shapes

    private func pieceShape(
        _ piece: ArkPiece
    ) -> some View {

        ZStack {

            RoundedRectangle(cornerRadius: 8)
                .fill(
                    piece.id == "roof"
                    ? Color.orange.opacity(0.9)
                    : Color.brown.opacity(0.9)
                )

            plankLines(for: piece)

            Text(piece.emoji)
                .font(.title)

        }
        .frame(
            width: piece.size.width,
            height: piece.size.height
        )
        .shadow(
            color: Color.black.opacity(0.15),
            radius: 3,
            y: 2
        )

    }

    private func miniPieceShape(
        _ piece: ArkPiece
    ) -> some View {

        RoundedRectangle(cornerRadius: 5)
            .fill(Color.brown.opacity(0.8))
            .frame(
                width: min(
                    piece.size.width * 0.35,
                    90
                ),
                height: min(
                    piece.size.height * 0.35,
                    35
                )
            )
            .overlay {

                RoundedRectangle(cornerRadius: 5)
                    .stroke(
                        Color.brown,
                        lineWidth: 2
                    )

            }

    }

    private func plankLines(
        for piece: ArkPiece
    ) -> some View {

        Canvas { context, size in

            var path = Path()

            let spacing: CGFloat = 18

            var x = spacing

            while x < size.width {

                path.move(
                    to: CGPoint(
                        x: x,
                        y: 0
                    )
                )

                path.addLine(
                    to: CGPoint(
                        x: x,
                        y: size.height
                    )
                )

                x += spacing

            }

            context.stroke(
                path,
                with: .color(
                    Color.black.opacity(0.15)
                ),
                lineWidth: 1
            )

        }

    }

    // MARK: - Drag Logic

    private func handleDrop(
        piece: ArkPiece,
        location: CGPoint
    ) {

        guard let blueprintFrame = blueprintFrame else {

            resetPiece(piece)
            return

        }

        let targetX =
            blueprintFrame.minX
            + blueprintFrame.width
            * piece.targetPosition.x

        let targetY =
            blueprintFrame.minY
            + blueprintFrame.height
            * piece.targetPosition.y

        let target = CGPoint(
            x: targetX,
            y: targetY
        )

        let distance = distance(
            from: location,
            to: target
        )

        if distance <= snapDistance {

            placePiece(piece)

        } else {

            resetPiece(piece)

        }

    }

    private func placePiece(
        _ piece: ArkPiece
    ) {

        withAnimation(
            .spring(
                response: 0.4,
                dampingFraction: 0.65
            )
        ) {

            placedPieceIDs.insert(piece.id)
            dragOffsets[piece.id] = .zero
            activePieceID = nil

        }

        feedback = "✨ \(piece.name) snapped into place!"

        checkCompletion()

    }

    private func resetPiece(
        _ piece: ArkPiece
    ) {

        withAnimation(
            .spring(
                response: 0.4,
                dampingFraction: 0.7
            )
        ) {

            dragOffsets[piece.id] = .zero
            activePieceID = nil

        }

        feedback = "Try again. Find the matching blueprint shape."

    }

    // MARK: - Completion

    private func checkCompletion() {

        if placedPieceIDs.count == arkPieces.count {

            DispatchQueue.main.asyncAfter(
                deadline: .now() + 0.7
            ) {

                withAnimation(.easeInOut) {

                    completed = true
                    feedback = "🎉 The ark is built!"

                }

            }

        }

    }

    private var completedView: some View {

        VStack(spacing: 20) {

            Text("🚢")
                .font(.system(size: 80))

            Text("The Ark Is Built!")
                .font(.largeTitle)
                .bold()

            Text(
                "Noah did everything just as GOD commanded him."
            )
            .font(.title3)
            .multilineTextAlignment(.center)

            Text("📖 Genesis 6:22")
                .font(.headline)
                .foregroundStyle(.secondary)

            Button("Continue Story") {

                onComplete()

            }
            .buttonStyle(.borderedProminent)

        }

    }

    // MARK: - Helpers

    private func targetPosition(
        for piece: ArkPiece,
        geometry: GeometryProxy
    ) -> CGPoint {

        CGPoint(
            x: geometry.size.width
                * piece.targetPosition.x,
            y: geometry.size.height
                * piece.targetPosition.y
        )

    }

    private func distance(
        from first: CGPoint,
        to second: CGPoint
    ) -> CGFloat {

        let xDistance = first.x - second.x
        let yDistance = first.y - second.y

        return sqrt(
            xDistance * xDistance
            + yDistance * yDistance
        )

    }

    // MARK: - Blueprint Frame

    @State private var blueprintFrame: CGRect?

}

struct ArkPiece: Identifiable {

    let id: String
    let name: String
    let emoji: String
    let targetPosition: CGPoint
    let size: CGSize
}

#Preview {

    BuildArkView(
        onComplete: {}
    )

}
