//
//  MapCard.swift
//  Tyler
//
//  Created by Hyunjun Kim on 10/6/23.
//

import SwiftUI

struct MapCard: View {
    var namespace: Namespace.ID
    @Binding var isShow: Bool
    
    var body: some View {
        Button {
            withAnimation(.openCard) {
                isShow.toggle()
            }
        } label: {
            Image("MapExample")
                .resizable()
                .scaledToFit()
                .overlay {
                    Color.black.opacity(0.7)
                }
                .roundedCorner(radius: 30, corners: [.topRight, .bottomLeft, .bottomRight])
                .matchedGeometryEffect(id: "background", in: namespace)
            
                .overlay {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("오리런")
                            .font(.title)
                            .bold()
                            .matchedGeometryEffect(id: "title", in: namespace)
                        HStack {
                            Image(systemName: "map.fill")
                            Text("건국대학교")
                        }
                        .matchedGeometryEffect(id: "subtitle", in: namespace)
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(30)
                }
                .padding(.horizontal, 20)
        }
        .buttonStyle(CardButton())
    }
}

struct CardButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}

#Preview {
    HeroAnimationView()
}
