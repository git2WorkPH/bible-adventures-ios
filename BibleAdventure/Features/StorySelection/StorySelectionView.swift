import SwiftUI

struct StorySelectionView: View {
    var body: some View {
        VStack(spacing:20){
            
            Spacer()
            
            Text("Choose Adventure").font(.largeTitle).bold()
            
            NavigationLink("🚢 Noah's Ark"){
             StoryPlayerView()
            }
            
            Button("🔒 Moses"){}.padding()
            
            Button("🔒 David"){}.padding()
            
            Button("🔒 Daniel"){}.padding()
            
            Spacer()
        }
    }
}

#Preview {
    StorySelectionView()
}
