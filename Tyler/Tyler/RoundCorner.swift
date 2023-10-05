//
//  RoundCorner.swift
//  Tyler
//
//  Created by Hyunjun Kim on 10/5/23.
//

import SwiftUI

struct RoundCorner : Shape {
    var radius : CGFloat
    var corners : UIRectCorner
    
    /// UIBezierPath 와 UIRectCorner 를 사용하여 원하는 곳에 CornerRadius 를 적용시키는 함수
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    /// 해당 사각형의 원하는 곳에 round 를 적용시키는 View extension
    /// - Parameters:
    ///   - radius: CornerRadius 값
    ///   - corners: UIRectCorner는 iOS에서 뷰의 모서리를 나타내는 열거형(enum)이다. 사각형의 모서리를 [.topLeft, .topRight, .bottomLeft, .bottomRight] 로 선택할 수 있음
    /// - Returns: 입력해준 radius 와 corners 를 적용시킨 도형
    func roundedCorner(_ radius : CGFloat, corners : UIRectCorner) -> some View {
        clipShape(RoundCorner(radius: radius, corners: corners))
    }
}
