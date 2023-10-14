//
//  WatchConnectivityView.swift
//  WatchTyler Watch App
//
//  Created by Hyunjun Kim on 10/10/23.
//

import SwiftUI

struct WatchConnectivityView: View {
    
    @StateObject var deviceCommunicator = DeviceCommunicator.shared
    
    @State private var scrollValue = 0.0
    
    var body: some View {
        TabView {
            NavigationStack {
                VStack {
                    Text("Scroll value: \(scrollValue, specifier: "%.1f")")
                        .focusable(true)
                        .digitalCrownRotation($scrollValue)
                    
                    Button("Send Message") {
                        deviceCommunicator.session.sendMessage(["messageScrollValue" : self.scrollValue], replyHandler: nil) {(error) in
                            print(error.localizedDescription)
                        }
                    }
                    
                    Button("Transfer Data") {
                        deviceCommunicator.session.transferUserInfo(["transferScrollValue" : self.scrollValue])
                    }
                }
                .navigationTitle("Send Data")
            }
            
            NavigationStack {
                VStack(alignment: .leading) {
                    Text("Message")
                    Text("\(deviceCommunicator.messageText)")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .foregroundStyle(.gray.opacity(0.3))
                        }
                    Text("Transfer Info")
                    Text("\(deviceCommunicator.transferText)")
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
