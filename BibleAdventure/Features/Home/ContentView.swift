//
//  ContentView.swift
//  BibleAdventure
//
//  Created by jc on 6/7/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    var body: some View {
        NavigationStack{
            VStack{
                
                Spacer()
                
                Text("🌈").font(.system(size: 80))
                Text("Bible Adventure").font(.largeTitle)
                    .fontWeight(.bold)
                
                VStack(spacing: 4){
                    Text("Journey to Understanding")
                    Text("Who God Is")
                }
                
                Spacer()
                
                NavigationLink("New Adventure") {
                    StorySelectionView()
                }
                
                Button("Continue") {}.padding()
                
                Button("Settings") {
                    print("Opening settings...")
                }.padding()
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
