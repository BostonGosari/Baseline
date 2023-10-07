//
//  LoginKakaoButton.swift
//  Austin
//
//  Created by Seungui Moon on 10/7/23.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

struct LoginKakaoButton: View {
    var body: some View {
        VStack {
            Button{
                if (UserApi.isKakaoTalkLoginAvailable()) {
                    UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                        if let error = error {
                            print(error)
                        }
                        else {
                            print("loginWithKakaoTalk() success.")

                            //do something
                            _ = oauthToken
                        }
                    }
                } else {
                    print("login enabled")
                }
            } label: {
                Text("Login with Kakao")
            }
        }
    }
}

#Preview {
    LoginKakaoButton()
}
