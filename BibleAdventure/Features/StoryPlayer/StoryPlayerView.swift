import SwiftUI



struct StoryPlayerView: View {
    
    let story = StoryEngine.noah
    
    @State private var currentPage: Int = 0
    
    @State private var buttonName = "Next"
    
    var body: some View {
    
        VStack(){
            
            Spacer()
            
            Text("📖 Noah's Ark").font(.largeTitle).bold()
            
            Spacer()
            
            Text(story.dialoguePages[currentPage].speaker)
                .font(.headline)
                .foregroundStyle(.blue)

            Text(story.dialoguePages[currentPage].text)
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding()

            Text("📖 \(story.dialoguePages[currentPage].reference)")
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(story.dialoguePages[currentPage].reference).font(.caption).foregroundStyle(.gray)
            
            Spacer()
            
            Button(buttonName){
                if currentPage < story.dialoguePages.count - 1 {
                    currentPage += 1
                }
            }
            
            Spacer()
            
        }.padding()
    }
}

#Preview {
    StoryPlayerView()
}
