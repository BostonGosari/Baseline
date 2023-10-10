//
//  Carousel.swift
//  Tyler
//
//  Created by Hyunjun Kim on 10/11/23.
//

import SwiftUI

struct Carousel<Content: View>: View {
    typealias PageIndex = Int
    
    let pageCount: Int
    let edgeSpace: CGFloat
    let spacing: CGFloat
    let content: (PageIndex) -> Content
    
    @GestureState var dragOffset: CGFloat = 0
    @Binding var currentIndex: Int
    
    init(
        pageCount: Int,
        edgeSpace: CGFloat,
        spacing: CGFloat,
        currentIndex: Binding<Int>, // currentIndex를 Binding으로 받아옴
        @ViewBuilder content: @escaping (PageIndex) -> Content
    ) {
        self.pageCount = pageCount
        self.edgeSpace = edgeSpace
        self.spacing = spacing
        self._currentIndex = currentIndex // Binding으로 currentIndex 연결
        self.content = content
    }
    
    var body: some View {
        GeometryReader { proxy in
            let baseOffset = spacing + edgeSpace
            let pageWidth = proxy.size.width - (edgeSpace + spacing) * 2
            let offsetX = baseOffset + CGFloat(currentIndex) * -pageWidth + CGFloat(currentIndex) * -spacing + dragOffset
            
            HStack(spacing: spacing) {
                ForEach(0..<pageCount, id: \.self) { pageIndex in
                    self.content(pageIndex)
                        .frame(width: pageWidth, height: proxy.size.height)
                        .scaleEffect(pageIndex == currentIndex ? 1 : 0.95)
                }
                .contentShape(Rectangle())
            }
            .offset(x: offsetX)
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, out, _ in
                        out = value.translation.width
                    }
                    .onEnded { value in
                        let offsetX = value.translation.width
                        let progress = -offsetX / pageWidth
                        let increment = Int(progress.rounded())
                        
                        currentIndex = max(min(currentIndex + increment, pageCount - 1), 0)
                    }
            )
            .animation(.spring, value: dragOffset)
        }
    }
}

#Preview {
    CarouselView()
}
