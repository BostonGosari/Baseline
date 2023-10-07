//
//  AustinApp.swift
//  Austin
//
//  Created by Hyunjun Kim on 10/5/23.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct AustinApp: App {
    init() {
       // Kakao SDK 초기화
       KakaoSDK.initSDK(appKey: "3ec4e9cf6844cce53ad2d4fcba1df727")
   }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
