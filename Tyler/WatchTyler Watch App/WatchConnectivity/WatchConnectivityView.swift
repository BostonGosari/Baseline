//
//  WatchConnectivityView.swift
//  WatchTyler Watch App
//
//  Created by Hyunjun Kim on 10/10/23.
//

import SwiftUI

struct WatchConnectivityView: View {
    
    @State private var scrollAmount = 0.0
    
    var body: some View {
        TabView {
            NavigationStack {
                VStack {
                    Text("Scroll value: \(scrollAmount, specifier: "%.1f")")
                        .focusable(true)
                        .digitalCrownRotation($scrollAmount)
                    
                    Button("Send Message") {
                        
                    }
                    
                    Button("Transfer Data") {
                        
                    }
                }
                .navigationTitle("Send Data")
            }
            
            NavigationStack {
                VStack(alignment: .leading) {
                    Text("Message")
                    Text("Message")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .foregroundStyle(.gray.opacity(0.3))
                        }
                    Text("Transfer Info")
                    Text("Transfer Info")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .foregroundStyle(.gray.opacity(0.3))
                        }
                }
                .navigationTitle("Get Data")
            }
        }
    }
}

#Preview {
    WatchConnectivityView()
}
