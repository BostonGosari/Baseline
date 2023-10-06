//
//  HeroAnimationView.swift
//  Tyler
//
//  Created by Hyunjun Kim on 10/6/23.
//

import SwiftUI

struct HeroAnimationView: View {
    
    @Namespace var namespace
    @State private var isShow = false
    
    var body: some View {
        ZStack {
            ScrollView {
                Text("OUTLINE")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                if !isShow {
                    CardView(namespace: namespace, isShow: $isShow)
                }
                Rectangle()
                    .foregroundStyle(.clear)
            }
            
            if isShow {
                CardDetailView(namespace: namespace, isShow: $isShow)
            }
            
        }
    }
}

#Preview {
    NavigationStack {
        HeroAnimationView()
    }
}
