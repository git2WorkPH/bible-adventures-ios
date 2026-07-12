import SwiftUI

struct WoodBlockView: View {

    let style: WoodStyle

    var body: some View {

        ZStack {

            RoundedRectangle(cornerRadius: 12)
                .fill(baseColour)

            grainPattern

            barkEdges

            woodRings

        }
        .frame(
            width: 120,
            height: 65
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 12)
        )
        .overlay {

            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    edgeColour,
                    lineWidth: 3
                )

        }
        .shadow(
            color: .black.opacity(0.15),
            radius: 4,
            y: 3
        )

    }

    // MARK: - Grain

    private var grainPattern: some View {

        Canvas { context, size in

            var path = Path()

            for index in 0..<5 {

                let y =
                    CGFloat(index + 1)
                    * size.height / 6

                path.move(
                    to: CGPoint(
                        x: 5,
                        y: y
                    )
                )

                path.addCurve(
                    to: CGPoint(
                        x: size.width - 5,
                        y: y
                    ),
                    control1: CGPoint(
                        x: size.width * 0.3,
                        y: y + grainCurve
                    ),
                    control2: CGPoint(
                        x: size.width * 0.7,
                        y: y - grainCurve
                    )
                )

            }

            context.stroke(
                path,
                with: .color(
                    grainColour.opacity(0.55)
                ),
                lineWidth: grainWidth
            )

        }

    }

    // MARK: - Bark

    private var barkEdges: some View {

        HStack {

            Rectangle()
                .fill(edgeColour.opacity(0.7))
                .frame(width: barkWidth)

            Spacer()

            Rectangle()
                .fill(edgeColour.opacity(0.7))
                .frame(width: barkWidth)

        }

    }

    // MARK: - Rings

    @ViewBuilder
    private var woodRings: some View {

        if style == .cypress {

            HStack {

                Spacer()

                ZStack {

                    Ellipse()
                        .stroke(
                            grainColour.opacity(0.7),
                            lineWidth: 2
                        )
                        .frame(
                            width: 28,
                            height: 42
                        )

                    Ellipse()
                        .stroke(
                            grainColour.opacity(0.6),
                            lineWidth: 2
                        )
                        .frame(
                            width: 17,
                            height: 29
                        )

                    Ellipse()
                        .stroke(
                            grainColour.opacity(0.5),
                            lineWidth: 2
                        )
                        .frame(
                            width: 8,
                            height: 16
                        )

                }
                .padding(.trailing, 12)

            }

        }

    }

    // MARK: - Style

    private var baseColour: Color {

        switch style {

        case .oak:
            return Color(
                red: 0.72,
                green: 0.48,
                blue: 0.25
            )

        case .cedar:
            return Color(
                red: 0.68,
                green: 0.28,
                blue: 0.18
            )

        case .cypress:
            return Color(
                red: 0.76,
                green: 0.62,
                blue: 0.34
            )

        case .pine:
            return Color(
                red: 0.88,
                green: 0.72,
                blue: 0.43
            )

        }

    }

    private var grainColour: Color {

        switch style {

        case .oak:
            return .brown

        case .cedar:
            return Color.red.opacity(0.7)

        case .cypress:
            return Color.brown.opacity(0.8)

        case .pine:
            return Color.orange.opacity(0.7)

        }

    }

    private var edgeColour: Color {

        switch style {

        case .oak:
            return Color.brown

        case .cedar:
            return Color(
                red: 0.38,
                green: 0.12,
                blue: 0.08
            )

        case .cypress:
            return Color(
                red: 0.45,
                green: 0.35,
                blue: 0.15
            )

        case .pine:
            return Color(
                red: 0.58,
                green: 0.40,
                blue: 0.18
            )

        }

    }

    private var grainCurve: CGFloat {

        switch style {

        case .oak:
            return 8

        case .cedar:
            return 3

        case .cypress:
            return 12

        case .pine:
            return 5

        }

    }

    private var grainWidth: CGFloat {

        switch style {

        case .oak:
            return 3

        case .cedar:
            return 1

        case .cypress:
            return 2

        case .pine:
            return 1.5

        }

    }

    private var barkWidth: CGFloat {

        switch style {

        case .oak:
            return 8

        case .cedar:
            return 5

        case .cypress:
            return 6

        case .pine:
            return 3

        }

    }

}

#Preview {

    VStack(spacing: 20) {

        WoodBlockView(style: .oak)

        WoodBlockView(style: .cedar)

        WoodBlockView(style: .cypress)

        WoodBlockView(style: .pine)

    }
    .padding()

}
