//
//  DeviceCommunicator.swift
//  Tyler
//
//  Created by Hyunjun Kim on 10/10/23.
//

import Foundation
import WatchConnectivity

class DeviceCommunicator: NSObject, WCSessionDelegate, ObservableObject {
    
    static let shared = DeviceCommunicator()
    
    let session = WCSession.default
    
    // From iOS
    @Published var messageText = ""
    @Published var transferText = ""
    
    // From watchOS
    @Published var messageScrollValue = 0.0
    @Published var transferScrollValue = 0.0

    
    override init() {
        super.init()
        if WCSession.isSupported() {
            session.delegate = self
            session.activate()
        } else {
            print("ERROR: Watch session not supported")
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("session activation failed with error: \(error.localizedDescription)")
            return
        }
    }
    
#if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) { }
    
    func sessionDidDeactivate(_ session: WCSession) { }
#endif
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            // From iOS
            self.messageText = message["messageText"] as? String ?? ""
            
            // From watchOS
            self.messageScrollValue = message["messageScrollValue"] as? Double ?? 0.0
        }
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any]) {
        DispatchQueue.main.async {
            // From iOS
            self.transferText = userInfo["transferText"] as? String ?? ""
            
            // From watchOS
            self.transferScrollValue = userInfo["transferScrollValue"] as? Double ?? 0.0
        }
    }
}
