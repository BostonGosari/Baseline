//
//  MapView.swift
//  Tyler
//
//  Created by Hyunjun Kim on 10/8/23.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
    static let duckRun = CLLocationCoordinate2D(latitude: 37.54161, longitude: 127.07648)
}

struct MapView: View {
    
    @State private var position: MapCameraPosition = .camera(.init(centerCoordinate: .duckRun, distance: 1800.0, heading: -80.0))
    
    var body: some View {
        VStack {
            Text("Map 표시")
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
            .mapControls {
                MapUserLocationButton()
                MapCompass()
                MapScaleView()
            }
            .safeAreaInset(edge: .bottom) {
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
                .frame(maxWidth: .infinity)
                .background(.thinMaterial)
            }
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .frame(maxWidth: .infinity)
            .frame(height: 450)
            .padding(.horizontal, 30)
            Text("hello world")
        }
    }
}

#Preview {
    MapView()
}
