//
//  HeroAnimationView.swift
//  Tyler
//
//  Created by Hyunjun Kim on 10/6/23.
//

import SwiftUI

struct HeroAnimationView: View {
    var body: some View {
        ScrollView {
            ZStack {
                Image("MapExample")
                    .resizable()
                    .scaledToFit()
                    .overlay {
                        Color.black.opacity(0.7)
                    }
                    .roundedCorner(radius: 40, corners: [.topRight, .bottomLeft, .bottomRight])
                VStack(alignment: .leading, spacing: 10) {
                    Text("오리런")
                        .font(.title)
                        .bold()
                    HStack {
                        Image(systemName: "map.fill")
                        Text("건국대학교")
                    }
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(30)
            }
            .padding(.horizontal, 20)
        }
        .navigationTitle("Hero Animation")
    }
}

#Preview {
    NavigationStack {
        HeroAnimationView()
    }
}
