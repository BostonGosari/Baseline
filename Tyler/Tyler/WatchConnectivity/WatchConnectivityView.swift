//
//  WatchConnectivityView.swift
//  Tyler
//
//  Created by Hyunjun Kim on 10/10/23.
//

import SwiftUI

struct WatchConnectivityView: View {
    
    @StateObject var deviceCommunicator = DeviceCommunicator.shared
    
    @State private var messageText = ""
    @State private var transferText = ""
    
    var body: some View {
        VStack {
            Text("Send **Data** to **watchOS**")
                .font(.title2)
            TextField("input message", text: $messageText)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(.thinMaterial)
                )
            Button {
                deviceCommunicator.session.sendMessage(["messageText" : self.messageText], replyHandler: nil) {(error) in
                    print(error.localizedDescription)
                }
            } label: {
                Text("Send Message")
            }
            .buttonStyle(.borderedProminent)
            
            TextField("input transfer info", text: $transferText)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(.thinMaterial)
                )
            Button {
                deviceCommunicator.session.transferUserInfo(["transferText" : self.transferText])
            } label: {
                Text("Transfer Data to watchOS")
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom, 50)
            
            
            Text("Get **Data** from **watchOS**")
                .font(.title2)
            VStack(alignment: .leading) {
                Text("Message")
                    .font(.title3)
                    .bold()
                Text("Crown Scroll Data : \(deviceCommunicator.messageScrollValue)")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(.thinMaterial)
            )
            VStack(alignment: .leading) {
                Text("Transfer Info")
                    .font(.title3)
                    .bold()
                Text("Crown Scroll Data : \(deviceCommunicator.transferScrollValue)")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(.thinMaterial)
            )
            
        }
        .padding()
    }
}

#Preview {
    WatchConnectivityView()
}
