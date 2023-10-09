//
//  LoginView.swift
//  Austin
//
//  Created by Seungui Moon on 10/7/23.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            LoginAppleButton()
            LoginKakaoButton()
        }
    }
}

#Preview {
    LoginView()
}
