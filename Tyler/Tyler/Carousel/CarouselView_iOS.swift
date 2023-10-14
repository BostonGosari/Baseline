//
//  CarouselView_iOS.swift
//  Tyler
//
//  Created by Hyunjun Kim on 10/11/23.
//

import SwiftUI

@available(iOS 17.0, *)
struct CarouselView_iOS: View {
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<5) {_ in
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .frame(width: 300, height: 400)
                        .foregroundStyle(.purple)
                        .containerRelativeFrame(.horizontal)
                        .scrollTransition(.animated, axis: .horizontal) { content, phase in
                            content
                                .opacity(phase.isIdentity ? 1.0 : 0.9)
                                .scaleEffect(phase.isIdentity ? 1.0 : 0.9)
                        }
                }
            }
            .scrollTargetLayout()
        }
        .contentMargins(.horizontal, 50)
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.never)
    }
}

@available(iOS 17.0, *)
#Preview {
    CarouselView_iOS()
}
