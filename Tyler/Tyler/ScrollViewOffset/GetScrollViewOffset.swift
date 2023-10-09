//
//  GetScrollViewOffset.swift
//  Tyler
//
//  Created by Hyunjun Kim on 10/6/23.
//

import SwiftUI

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View {

    /// ```swift
    /// @State private var scrollViewOffset: CGFloat = 0
    ///
    /// .onScrollViewOffsetChanged { value
    ///    in scrollViewOffset = value
    /// }
    /// ```
    /// scrollViewOffset 변수 선언을 해준뒤 함수를 사용하여 scrollViewOffset 의 변화를 추적
    func onScrollViewOffsetChanged(action: @escaping (_ offset: CGFloat) -> Void) -> some View {
        self
            .background(
                GeometryReader {geo in
                    Text("")
                        .preference(key: ScrollViewOffsetPreferenceKey.self, value: geo.frame(in: .global).minY)
                }
            )
            .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
                action(value)
            }
    }
}
