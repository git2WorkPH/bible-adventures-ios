import SwiftUI

struct EnterArkView: View {

    let onComplete: () -> Void

    private let familyMembers: [ArkFamilyMember] = [
        ArkFamilyMember(id: "noah", name: "Noah", emoji: "👨🏻"),
        ArkFamilyMember(id: "wife", name: "Noah's Wife", emoji: "👩🏻"),
        ArkFamilyMember(id: "shem", name: "Shem", emoji: "👨🏻"),
        ArkFamilyMember(id: "shemWife", name: "Shem's Wife", emoji: "👩🏻"),
        ArkFamilyMember(id: "ham", name: "Ham", emoji: "👨🏽"),
        ArkFamilyMember(id: "hamWife", name: "Ham's Wife", emoji: "👩🏽"),
        ArkFamilyMember(id: "japheth", name: "Japheth", emoji: "👨🏼"),
        ArkFamilyMember(id: "japhethWife", name: "Japheth's Wife", emoji: "👩🏼")
    ]

    @State private var enteredMemberIDs: Set<String> = []
    @State private var dragOffsets: [String: CGSize] = [:]

    @State private var arkDoorFrame: CGRect?

    @State private var doorClosed = false
    @State private var rainStarted = false
    @State private var completed = false

    @State private var feedback = "Drag Noah and his family into the ark."
    @State private var activeMemberID: String?

    var body: some View {

        ScrollView {

            VStack(spacing: 24) {

                headerView

                progressView

                arkScene

                if completed {

                    completedView

                } else if doorClosed {

                    rainStatusView

                } else if everyoneInside {

                    closeDoorView

                } else {

                    familyTray

                }

            }
            .padding()

        }

    }

    // MARK: - Header

    private var headerView: some View {

        VStack(spacing: 8) {

            Text(
                rainStarted
                ? "🌧️ The Rain Begins"
                : "🚢 Enter the Ark"
            )
            .font(.largeTitle)
            .bold()

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

    // MARK: - Progress

    private var progressView: some View {

        VStack(spacing: 8) {

            ProgressView(
                value: Double(enteredMemberIDs.count),
                total: Double(familyMembers.count)
            )

            Text(
                "\(enteredMemberIDs.count) of \(familyMembers.count) safely inside"
            )
            .font(.caption)
            .foregroundStyle(.secondary)

        }

    }

    // MARK: - Ark Scene

    private var arkScene: some View {

        GeometryReader { geometry in

            ZStack {

                skyView

                if rainStarted {

                    rainView

                }

                groundView

                arkView

                enteredFamilyView

            }
            .clipShape(
                RoundedRectangle(cornerRadius: 24)
            )
            .overlay {

                RoundedRectangle(cornerRadius: 24)
                    .stroke(
                        Color.brown.opacity(0.3),
                        lineWidth: 2
                    )

            }

        }
        .frame(height: 400)

    }

    // MARK: - Sky

    private var skyView: some View {

        Rectangle()
            .fill(
                rainStarted
                ? Color.gray.opacity(0.45)
                : Color.blue.opacity(0.15)
            )
            .animation(
                .easeInOut(duration: 1),
                value: rainStarted
            )

    }

    // MARK: - Ground

    private var groundView: some View {

        VStack {

            Spacer()

            Rectangle()
                .fill(Color.green.opacity(0.35))
                .frame(height: 80)

        }

    }

    // MARK: - Ark

    private var arkView: some View {

        VStack(spacing: 0) {

            Spacer()

            ZStack {

                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.brown.opacity(0.9))
                    .frame(
                        width: 300,
                        height: 220
                    )

                plankLines

                VStack(spacing: 12) {

                    Text("NOAH'S ARK")
                        .font(.headline)
                        .bold()
                        .foregroundStyle(.white)

                    arkDoor

                }

            }

            Capsule()
                .fill(Color.brown)
                .frame(
                    width: 340,
                    height: 45
                )

            Spacer()
                .frame(height: 35)

        }

    }

    // MARK: - Planks

    private var plankLines: some View {

        Canvas { context, size in

            var path = Path()

            let spacing: CGFloat = 28

            var y = spacing

            while y < size.height {

                path.move(
                    to: CGPoint(
                        x: 0,
                        y: y
                    )
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
                    Color.black.opacity(0.15)
                ),
                lineWidth: 2
            )

        }
        .frame(
            width: 300,
            height: 220
        )

    }

    // MARK: - Ark Door

    private var arkDoor: some View {

        ZStack {

            RoundedRectangle(cornerRadius: 10)
                .fill(
                    doorClosed
                    ? Color.brown
                    : Color.black.opacity(0.65)
                )
                .frame(
                    width: 100,
                    height: 120
                )

            if doorClosed {

                VStack(spacing: 12) {

                    Image(
                        systemName: "door.left.hand.closed"
                    )
                    .font(.system(size: 40))

                    Text("CLOSED")
                        .font(.caption)
                        .bold()

                }
                .foregroundStyle(.white)

            } else {

                VStack(spacing: 8) {

                    Image(
                        systemName: "arrow.down.circle.fill"
                    )
                    .font(.system(size: 32))

                    Text("DROP HERE")
                        .font(.caption)
                        .bold()

                }
                .foregroundStyle(.white)

            }

        }
        .background {

            GeometryReader { geometry in

                Color.clear
                    .onAppear {

                        arkDoorFrame = geometry.frame(
                            in: .global
                        )

                    }
                    .onChange(
                        of: geometry.frame(in: .global)
                    ) { _, newFrame in

                        arkDoorFrame = newFrame

                    }

            }

        }

    }

    // MARK: - Entered Family

    private var enteredFamilyView: some View {

        VStack {

            Spacer()

            HStack(spacing: 2) {

                ForEach(familyMembers) { member in

                    if enteredMemberIDs.contains(member.id) {

                        Text(member.emoji)
                            .font(.title3)
                            .transition(
                                .scale.combined(
                                    with: .opacity
                                )
                            )

                    }

                }

            }
            .padding(.bottom, 42)

        }

    }

    // MARK: - Family Tray

    private var familyTray: some View {

        VStack(spacing: 16) {

            Text("👨‍👩‍👦 Noah's Family")
                .font(.title2)
                .bold()

            Text("Drag each family member into the ark.")
                .font(.caption)
                .foregroundStyle(.secondary)

            LazyVGrid(
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],
                spacing: 16
            ) {

                ForEach(familyMembers) { member in

                    if !enteredMemberIDs.contains(member.id) {

                        draggableMember(member)

                    }

                }

            }

        }

    }

    // MARK: - Draggable Member

    private func draggableMember(
        _ member: ArkFamilyMember
    ) -> some View {

        VStack(spacing: 8) {

            Text(member.emoji)
                .font(.system(size: 50))

            Text(member.name)
                .font(.headline)
                .minimumScaleFactor(0.7)

        }
        .frame(maxWidth: .infinity)
        .frame(height: 110)
        .background(
            Color.brown.opacity(0.1)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 16)
        )
        .overlay {

            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    activeMemberID == member.id
                    ? Color.orange
                    : Color.clear,
                    lineWidth: 3
                )

        }
        .offset(
            dragOffsets[member.id] ?? .zero
        )
        .zIndex(
            activeMemberID == member.id
            ? 10
            : 0
        )
        .gesture(

            DragGesture(
                coordinateSpace: .global
            )
            .onChanged { value in

                activeMemberID = member.id

                dragOffsets[member.id] =
                    value.translation

                feedback =
                    "Bring \(member.name) to the ark door."

            }
            .onEnded { value in

                handleDrop(
                    member: member,
                    location: value.location
                )

            }

        )

    }

    // MARK: - Close Door

    private var closeDoorView: some View {

        VStack(spacing: 20) {

            Text("✨ Everyone is safely inside!")
                .font(.title2)
                .bold()
                .multilineTextAlignment(.center)

            Text(
                "Noah and his family entered the ark."
            )
            .multilineTextAlignment(.center)

            Button {

                closeArkDoor()

            } label: {

                Label(
                    "Close the Ark",
                    systemImage: "door.left.hand.closed"
                )

            }
            .buttonStyle(.borderedProminent)

        }

    }

    // MARK: - Rain Status

    private var rainStatusView: some View {

        VStack(spacing: 16) {

            if rainStarted {

                Text("🌧️🌧️🌧️")
                    .font(.largeTitle)

                Text("The rain began to fall.")
                    .font(.title2)
                    .bold()

            } else {

                ProgressView()

                Text("The ark door is closed.")
                    .font(.headline)

            }

        }

    }

    // MARK: - Rain

    private var rainView: some View {

        GeometryReader { geometry in

            ForEach(0..<45, id: \.self) { index in

                Text("💧")
                    .font(.caption)
                    .position(
                        x: rainX(
                            index: index,
                            width: geometry.size.width
                        ),
                        y: rainY(
                            index: index,
                            height: geometry.size.height
                        )
                    )

            }

        }

    }

    // MARK: - Completed

    private var completedView: some View {

        VStack(spacing: 20) {

            Text("🌧️🚢")
                .font(.system(size: 70))

            Text("Safe Inside the Ark")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)

            Text(
                "Noah and his family were safely inside the ark."
            )
            .font(.title3)
            .multilineTextAlignment(.center)

            Text("📖 Genesis 7:13–16")
                .font(.headline)
                .foregroundStyle(.secondary)

            Button("Continue Story") {

                onComplete()

            }
            .buttonStyle(.borderedProminent)

        }

    }

    // MARK: - Drag Logic

    private func handleDrop(
        member: ArkFamilyMember,
        location: CGPoint
    ) {

        guard let arkDoorFrame else {

            resetMember(member)
            return

        }

        let expandedDoorFrame = arkDoorFrame.insetBy(
            dx: -60,
            dy: -60
        )

        if expandedDoorFrame.contains(location) {

            enterArk(member)

        } else {

            resetMember(member)

        }

    }

    private func enterArk(
        _ member: ArkFamilyMember
    ) {

        withAnimation(
            .spring(
                response: 0.4,
                dampingFraction: 0.65
            )
        ) {

            enteredMemberIDs.insert(member.id)
            dragOffsets[member.id] = .zero
            activeMemberID = nil

        }

        feedback =
            "✨ \(member.name) is safely inside!"

        if everyoneInside {

            DispatchQueue.main.asyncAfter(
                deadline: .now() + 0.5
            ) {

                feedback =
                    "✨ Everyone is inside. Close the ark."

            }

        }

    }

    private func resetMember(
        _ member: ArkFamilyMember
    ) {

        withAnimation(
            .spring(
                response: 0.4,
                dampingFraction: 0.7
            )
        ) {

            dragOffsets[member.id] = .zero
            activeMemberID = nil

        }

        feedback =
            "Try again. Drag \(member.name) to the ark door."

    }

    // MARK: - Door Logic

    private func closeArkDoor() {

        withAnimation(.easeInOut) {

            doorClosed = true
            feedback = "The ark door is closed."

        }

        DispatchQueue.main.asyncAfter(
            deadline: .now() + 1
        ) {

            withAnimation(.easeInOut(duration: 1)) {

                rainStarted = true
                feedback = "🌧️ The rain began to fall."

            }

        }

        DispatchQueue.main.asyncAfter(
            deadline: .now() + 3
        ) {

            withAnimation(.easeInOut) {

                completed = true

            }

        }

    }

    // MARK: - Helpers

    private var everyoneInside: Bool {

        enteredMemberIDs.count == familyMembers.count

    }

    private func rainX(
        index: Int,
        width: CGFloat
    ) -> CGFloat {

        let position = (index * 47) % 100

        return width * CGFloat(position) / 100

    }

    private func rainY(
        index: Int,
        height: CGFloat
    ) -> CGFloat {

        let position = (index * 31) % 100

        return height * CGFloat(position) / 100

    }

}

// MARK: - Family Member

struct ArkFamilyMember: Identifiable {

    let id: String
    let name: String
    let emoji: String
}

#Preview {

    EnterArkView(
        onComplete: {}
    )

}
