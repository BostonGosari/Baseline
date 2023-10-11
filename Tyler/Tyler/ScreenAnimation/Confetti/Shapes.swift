//
//  Shapes.swift
//  Tyler
//
//  Created by Simon Bachmann on 04.12.20.
//

import SwiftUI

struct ShapesView: View {
    var body: some View {
        VStack {
            Text("Confetti Components")
            Group {
                RoundedCross()
                SlimRectangle()
                Triangle()
            }
            .frame(width: 30, height: 30)
        }
    }
}

struct RoundedCross: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX, y: rect.maxY/3))
        path.addQuadCurve(to: CGPoint(x: rect.maxX/3, y: rect.minY), control: CGPoint(x: rect.maxX/3, y: rect.maxY/3))
        path.addLine(to: CGPoint(x: 2*rect.maxX/3, y: rect.minY))
        
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.maxY/3), control: CGPoint(x: 2*rect.maxX/3, y: rect.maxY/3))
        path.addLine(to: CGPoint(x: rect.maxX, y: 2*rect.maxY/3))

        path.addQuadCurve(to: CGPoint(x: 2*rect.maxX/3, y: rect.maxY), control: CGPoint(x: 2*rect.maxX/3, y: 2*rect.maxY/3))
        path.addLine(to: CGPoint(x: rect.maxX/3, y: rect.maxY))

        path.addQuadCurve(to: CGPoint(x: 2*rect.minX/3, y: 2*rect.maxY/3), control: CGPoint(x: rect.maxX/3, y: 2*rect.maxY/3))

        return path
    }
}

struct SlimRectangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX, y: 4*rect.maxY/5))
        path.addLine(to: CGPoint(x: rect.maxX, y: 4*rect.maxY/5))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))

        return path
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

#Preview {
    ShapesView()
}
