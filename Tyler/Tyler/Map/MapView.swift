//
//  MapView.swift
//  Tyler
//
//  Created by Hyunjun Kim on 10/8/23.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
    static let duckRun = CLLocationCoordinate2D(latitude: 37.54088, longitude: 127.07648)
}

struct MapView: View {
    
    @State private var position: MapCameraPosition = .automatic
    
    var body: some View {
        VStack {
            Text("Map 표시")
            Map() {
                UserAnnotation()
                Annotation("Duck Run", coordinate: .duckRun) {
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
