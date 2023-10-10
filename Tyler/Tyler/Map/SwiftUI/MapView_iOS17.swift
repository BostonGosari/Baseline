//
//  MapView-iOS17.swift
//  Tyler
//
//  Created by Hyunjun Kim on 10/9/23.
//

import MapKit
import SwiftUI

@available(iOS 17.0, *)
struct MapView_iOS17: View {
    
    @State private var position: MapCameraPosition = .camera(.init(centerCoordinate: .duckRun, distance: 1800.0, heading: -80.0))
    
    var body: some View {
        Map(position: $position) {
            UserAnnotation()
            Annotation("오리런", coordinate: .duckRun) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .foregroundStyle(.yellow)
                    Image("duck")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .padding(5)
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            HStack {
                Button{
                    withAnimation {
                        position = .camera(.init(centerCoordinate: .duckRun, distance: 1800.0, heading: -80.0))
                    }
                } label: {
                    Image("duck")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                        .padding(5)
                        .background {
                            RoundedRectangle(cornerRadius: 8, style: .circular)
                                .foregroundStyle(.yellow)
                        }
                        .padding()
                }
            }
            .frame(maxWidth: .infinity)
            .background(.thinMaterial)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .frame(maxWidth: .infinity)
        .frame(height: 450)
        .padding(.horizontal, 30)
    }
}

@available(iOS 17.0, *)
#Preview {
        MapView_iOS17()
}
