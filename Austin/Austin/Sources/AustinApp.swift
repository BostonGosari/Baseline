//
//  AustinApp.swift
//  Austin
//
//  Created by Hyunjun Kim on 10/5/23.
//

import KakaoSDKCommon
import KakaoSDKAuth
import SwiftUI

@main
struct AustinApp: App {
    init() {
       // Kakao SDK 초기화
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "KAKAO_APP_KEY") as? String else {
            return
        }
        KakaoSDK.initSDK(appKey: apiKey)
   }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
