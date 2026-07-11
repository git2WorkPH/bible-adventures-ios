import SwiftUI

struct RainbowCovenantView: View {

    let onComplete: () -> Void

    private let colors = [

        RainbowStripe(id: "red", colorName: "Red"),
        RainbowStripe(id: "orange", colorName: "Orange"),
        RainbowStripe(id: "yellow", colorName: "Yellow"),
        RainbowStripe(id: "green", colorName: "Green"),
        RainbowStripe(id: "blue", colorName: "Blue"),
        RainbowStripe(id: "purple", colorName: "Purple"),
        RainbowStripe(id: "indigo", colorName: "Indigo")
        

    ]

    @State private var completed = 0

    var body: some View {

        VStack(spacing: 24) {

            Text(" GOD's Covenant")
                .font(.largeTitle)
                .bold()

            Text("Help reveal the rainbow.")
                .font(.headline)

            rainbowView

            Spacer()

            if completed == colors.count {

                covenantView

            } else {

                colorButtons

            }

        }
        .padding()

    }

    // MARK: Rainbow

    private var rainbowView: some View {

        VStack(spacing: 6) {

            ForEach(0..<completed, id: \.self) { index in

                RoundedRectangle(cornerRadius: 20)
                    .fill(swiftUIColor(index))
                    .frame(height: 22)

            }

        }
        .frame(height: 180)

    }

    // MARK: Buttons

    private var colorButtons: some View {

        VStack(spacing: 12) {

            Button("🔴 Red") {

                addStripe()

            }

            Button("🟠 Orange") {

                addStripe()

            }

            Button("🟡 Yellow") {

                addStripe()

            }

            Button("🟢 Green") {

                addStripe()

            }

            Button("🔵 Blue") {

                addStripe()

            }

            Button("🟣 Purple") {

                addStripe()

            }
            
            Button("🔵🟣 Indigo") {

                addStripe()

            }
            

        }
        .buttonStyle(.borderedProminent)

    }

    // MARK: Covenant

    private var covenantView: some View {

        VStack(spacing: 20) {

            Text("")
                .font(.system(size: 80))

            Text("The Rainbow Appears")
                .font(.largeTitle)
                .bold()

            Text("""
"I have set my rainbow in the clouds, and it will be the sign of the covenant between me and the earth."
""")
            .multilineTextAlignment(.center)

            Text("Genesis 9:13")
                .foregroundStyle(.secondary)

            Button("Finish Noah's Story") {

                onComplete()

            }
            .buttonStyle(.borderedProminent)

        }

    }

    // MARK: Logic

    private func addStripe() {

        guard completed < colors.count else {
            return
        }

        withAnimation(.easeInOut) {

            completed += 1

        }

    }

    private func swiftUIColor(
        _ index: Int
    ) -> Color {

        switch index {

        case 0:
            .red

        case 1:
            .orange

        case 2:
            .yellow

        case 3:
            .green

        case 4:
            .blue

        default:
            .purple

        }

    }

}

#Preview {

    RainbowCovenantView(
        onComplete: {}
    )

}
