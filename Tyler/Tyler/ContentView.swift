//
//  ContentView.swift
//  Tyler
//
//  Created by Hyunjun Kim on 10/5/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Map") {
                    NavigationLink("MapKit") {
                        
                    }
                }
                Section("디저트") {
                    NavigationLink("Rounded Corner") {
                        RoundCornerView()
                    }
                    NavigationLink("Hero Animation") {
                        HeroAnimationView()
                    }
                }
            }
            .navigationTitle("기능 구현")
        }
    }
}

#Preview {
    ContentView()
}
