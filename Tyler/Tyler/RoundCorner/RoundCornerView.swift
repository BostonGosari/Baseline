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
        ScrollView {
            Rectangle()
                .frame(width: 150, height: 150)
                .foregroundStyle(.green)
                .roundedCorner(radius: 40, corners: [.topRight, .bottomLeft, .bottomRight])
        }
        .navigationTitle("Rounded Corner")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        RoundCornerView()
    }
}
