//
//  PathCustomView.swift
//  Helia
//
//  Created by hyebin on 10/11/23.
//

import CoreLocation
import SwiftUI

struct PathCustomView: View {
    @State private var scale: CGFloat = 1
    @State private var lastScale: CGFloat = 0
    @State private var offset: CGSize = .zero
    @State private var lastStoredOffset: CGSize = .zero
    @State private var angle: Angle = .degrees(0)
    @State private var lastAngle: Angle = .degrees(0)
        
    let locations = [
        CLLocationCoordinate2D(latitude: 36.01719, longitude: 129.31855),
        CLLocationCoordinate2D(latitude: 36.01691, longitude: 129.3181),
        CLLocationCoordinate2D(latitude: 36.01663, longitude: 129.31851),
        CLLocationCoordinate2D(latitude: 36.0169, longitude: 129.31887),
        CLLocationCoordinate2D(latitude: 36.01719, longitude: 129.31855),
    ]
    
    var body: some View {
        drawLine
            .ignoresSafeArea()
            .scaleEffect(scale)
            .offset(offset)
            .rotationEffect(angle)
            .gesture(dragGesture)
            .gesture(rotationGesture)
            .simultaneousGesture(magnificationGesture)
    }
}

extension PathCustomView {
    private var dragGesture: some Gesture {
        return DragGesture()
            .onChanged { value in
                let translation = value.translation
                offset = CGSize(
                    width: translation.width+lastStoredOffset.width,
                    height: translation.height+lastStoredOffset.height
                )
            }
            .onEnded { value in
                lastStoredOffset = offset
            }
    }
    
    private var rotationGesture: some Gesture {
        return RotationGesture()
            .onChanged { value in
                angle = lastAngle+value
            }
         .onEnded { value in
             withAnimation(.spring) {
                 lastAngle = angle
             }
         }
    }
    
    private var magnificationGesture: some Gesture {
        return MagnificationGesture()
            .onChanged { value in
                let updatedScale = value + lastScale
                scale = (updatedScale < 1 ? 1 : updatedScale)
            }
            .onEnded { value in
                withAnimation(.easeInOut(duration: 0.2)) {
                    if scale < 1 {
                        scale = 1
                        lastScale = 0
                    } else {
                        lastScale = scale-1
                    }
                }
            }
    }
    
    private var drawLine: some View {
        Path { path in
            for (index, location) in locations.enumerated() {
                let point = CGPoint(
                    x: UIScreen.main.bounds.width / 2 + CGFloat(location.longitude - locations[0].longitude) * 300000,
                    y: UIScreen.main.bounds.width / 2 - CGFloat(location.latitude - locations[0].latitude) * 300000
                )
                if index == 0 {
                    path.move(to: point)
                } else {
                    path.addLine(to: point)
                }
            }
        }
        .stroke(Color.orange, lineWidth: 5)
        .aspectRatio(contentMode: .fit)
    }
}

#Preview {
    PathCustomView()
}
