import SwiftUI

struct StoryPage {
    let text: String
    let reference: String
}

struct StoryPlayerView: View {
    
    let pages = [
        StoryPage(
               text: "God said to Noah, 'I have decided to put an end to all people.'",
               reference: "Genesis 6:13"
           ),

           StoryPage(
               text: "Make yourself an ark of cypress wood.",
               reference: "Genesis 6:14"
           ),

           StoryPage(
               text: "Bring two of every living creature into the ark.",
               reference: "Genesis 6:19"
           )
        ]
    
    @State private var currentPage: Int = 0
    
    @State private var buttonName = "Next"
    
    var body: some View {
    
        VStack(){
            
            Spacer()
            
            Text("📖 Noah's Ark").font(.largeTitle).bold()
            
            Spacer()
            
            Text(pages[currentPage].text)
                
            Text(pages[currentPage].reference).font(.caption).foregroundStyle(.gray)
            
            Spacer()
            
            Button(buttonName){
                if currentPage < pages.count - 1 {
                    currentPage += 1
                    if(buttonName == "Previous"){
                        buttonName = "Next"
                    }
                }else{
                    buttonName = "Previous"
                    currentPage -= 1
                }
            }
            
            Spacer()
            
        }.padding()
    }
}

#Preview {
    StoryPlayerView()
}
