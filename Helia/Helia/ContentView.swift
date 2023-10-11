//
//  ContentView.swift
//  Helia
//
//  Created by Hyunjun Kim on 10/5/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            UserPathView()
                .tabItem{Image(systemName: "paintpalette")}
            
            PathCustomView()
                .tabItem{Image(systemName: "line.diagonal")}
        }
    }
}


#Preview {
    ContentView()
}
