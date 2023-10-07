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
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                if !isShow {
                    CardView(namespace: namespace, isShow: $isShow)
                        .transition(
                            .asymmetric(
                                insertion: .opacity.animation(.easeInOut(duration: 0.1)),
                                removal: .opacity.animation(.easeInOut(duration: 0.3).delay(0.2))
                            )
                        )
                }
            }
            if isShow {
                CardDetailView(namespace: namespace, isShow: $isShow)
                    .zIndex(1)
                    .transition(
                        .asymmetric(
                            insertion: .opacity.animation(.easeInOut(duration: 0.1)),
                            removal: .opacity.animation(.easeInOut(duration: 0.3).delay(0.2))
                        )
                    )
            }
        }
    }
}

#Preview {
    NavigationStack {
        HeroAnimationView()
    }
}
