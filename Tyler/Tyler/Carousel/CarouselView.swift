//
//  CarouselView.swift
//  Tyler
//
//  Created by Hyunjun Kim on 10/11/23.
//

import SwiftUI

struct CarouselView: View {
    
    let pageCount = 4
    let edgeSpace: CGFloat = 30
    let spacing: CGFloat = 5
    @State var currentIndex = 0
    
    var body: some View {
        ScrollView {
            Carousel(pageCount: pageCount, edgeSpace: edgeSpace, spacing: spacing, currentIndex: $currentIndex) { pageIndex in
                Rectangle()
                    .foregroundStyle(.green)
                    .frame(height: 450)
                    .roundedCorner(radius: 40, corners: [.topRight, .bottomLeft, .bottomRight])
                    .overlay {
                        Text("\(pageIndex)")
                    }
            }
            .frame(height: 500)
            
            HStack {
                ForEach(0..<pageCount, id: \.self) { i in
                    Circle()
                        .frame(width: 10)
                        .foregroundStyle(currentIndex == i ? .green : .gray)
                        .animation(.spring, value: currentIndex)
                }
            }
            .padding(.bottom)
            Text("currentIndex : \(currentIndex)")
        }
    }
}

#Preview {
    CarouselView()
}
