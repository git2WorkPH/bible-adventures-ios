import SwiftUI

struct SplashView: View {
    @State private var showContent = false
    @State private var scale = 0.9
    @State private var opacity = 0.0

    var body: some View {
        if showContent {
            ContentView()
        } else {
            ZStack {
                LinearGradient(
                       colors: [.blue, .green],
                       startPoint: .top,
                       endPoint: .bottom
                   )
                   .ignoresSafeArea()

                   VStack(spacing: 20) {
                       Image("AppIcon")
                           .resizable()
                           .frame(width: 220, height: 220)
                           .clipShape(RoundedRectangle(cornerRadius: 40))
                           .shadow(radius: 20)

                       Text("Bible Adventure")
                           .font(.largeTitle)
                           .bold()
                           .foregroundColor(.white)
                   }

                // Full-screen splash artwork
                Image("SplashBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                // Optional dark overlay for better text contrast
                Color.black.opacity(0.25)
                    .ignoresSafeArea()

                VStack(spacing: 20) {

                    Text("Bible Adventure")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Text("Journey to Understanding Who God Is")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white.opacity(0.95))

                    ProgressView()
                        .tint(.white)
                        .padding(.top, 25)
                }
                .scaleEffect(scale)
                .opacity(opacity)
            }
            .onAppear {
                withAnimation(.easeOut(duration: 1.2)) {
                    scale = 1.0
                    opacity = 1.0
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation(.easeInOut) {
                        showContent = true
                    }
                }
            }
        }
    }
}
