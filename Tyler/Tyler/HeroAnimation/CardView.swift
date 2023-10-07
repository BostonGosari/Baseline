//
//  CardView.swift
//  Tyler
//
//  Created by Hyunjun Kim on 10/6/23.
//

import SwiftUI

struct CardView: View {
    var namespace: Namespace.ID
    @Binding var isShow: Bool
        
    var body: some View {
        Button {
            withAnimation(.openCard) {
                isShow = true
            }
        } label: {
            ZStack {
                mapImage
                mapInformation
            }
        }
        .buttonStyle(CardButton())
        .padding(.horizontal, 20)
    }
    
    // MARK: View Components
    
    private var mapImage: some View {
        Image("MapSample")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .roundedCorner(radius: 30, corners: [.topRight, .bottomLeft, .bottomRight])
            .matchedGeometryEffect(id: "map", in: namespace)
    }
    
    private var mapInformation: some View {
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
}

#Preview {
    HeroAnimationView()
}
