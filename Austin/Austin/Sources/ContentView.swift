//
//  ContentView.swift
//  Austin
//
//  Created by Hyunjun Kim on 10/5/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            LoginView()
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("Login")
                }
        }
    }
}

#Preview {
    ContentView()
}
