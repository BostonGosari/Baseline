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
                    MapCard(namespace: namespace, isShow: $isShow)
                }
                Rectangle()
                    .foregroundStyle(.clear)
            }
            
            if isShow {
                MapDetailView(namespace: namespace, isShow: $isShow)
                    .zIndex(1)
//                    .transition(
//                        .asymmetric(
//                            insertion: .opacity.animation(.easeInOut(duration: 0.1)),
//                            removal: .opacity.animation(.easeInOut(duration: 0.3))
//                        )
//                    )
            }
        }
    }
}

#Preview {
    NavigationStack {
        HeroAnimationView()
    }
}
