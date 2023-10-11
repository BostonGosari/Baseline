//
//  ConfettiView.swift
//  Tyler
//
//  Created by Hyunjun Kim on 10/11/23.
//

import SwiftUI

struct ConfettiView: View {
    
    @State private var counter = 0
    
    var body: some View {
        ZStack {
            
            /// - Parameters:
            ///   - counter: Counter가 변하는 것이 애니메이션트리거입니다.
            ///   - num: 요소들의 갯수
            ///   - confettis: 요소들의 종류
            ///   - colors: 색상 배열
            ///   - confettiSize: 요소들의 크기
            ///   - rainHeight: 떨어지는 거리
            ///   - fadesOut: 투명도를 점점 줄일 것인지
            ///   - opacity: 최대 투명도
            ///   - openingAngle: 시작 앵글
            ///   - closingAngle: 끝 앵글
            ///   - radius: 범위 반경
            ///   - repetitions: 반복 횟수
            ///   - repetitionInterval: 반복 시간
            Confetti(counter: $counter,
//                     confettis: [.text("hello")],
                     colors: [.blue, .yellow, .orange, .purple, .pink],
                     confettiSize: 10,
                     openingAngle: .degrees(50),
                     closingAngle: .degrees(130),
                     radius: 400)
            Button("Confetti") {
                counter += 1
            }
            .buttonStyle(.bordered)
        }
        
    }
}

#Preview {
    ConfettiView()
}
