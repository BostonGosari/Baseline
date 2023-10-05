//
//  RoundCornerView.swift
//  Tyler
//
//  Created by Hyunjun Kim on 10/6/23.
//

import SwiftUI

/// roundedCorner 사용 예시
struct RoundCornerView: View {
    var body: some View {
        Rectangle()
            .frame(width: 100, height: 100)
            .foregroundStyle(.green)
            .roundedCorner(radius: 20, corners: [.topRight, .bottomLeft, .bottomRight])
    }
}

#Preview {
    RoundCornerView()
}
