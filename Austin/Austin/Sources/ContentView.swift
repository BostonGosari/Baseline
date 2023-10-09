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
            CoreDataView()
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("Core Data")
                }
        }
    }
}

#Preview {
    ContentView()
}
