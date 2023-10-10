//
//  MapView.swift
//  Tyler
//
//  Created by Hyunjun Kim on 10/8/23.
//
import CoreLocation
import MapKit
import SwiftUI

struct RunPoint: Identifiable {
    let id = UUID()
    let title: String
    let coordinate: CLLocationCoordinate2D
    let image: String
}

struct MapView_iOS16: View {
    
    @State private var region = MKCoordinateRegion(
        center: .duckRun,
        latitudinalMeters: 600,
        longitudinalMeters: 600
    )
    
    @State private var camera = MKMapCamera(lookingAtCenter: .duckRun, fromDistance: 1800, pitch: 0, heading: -80)
        
    @State private var interactionMode: MapInteractionModes = .all
    @State private var userTracking: MapUserTrackingMode = .none
    
    let locationManager = CLLocationManager()
    
    let duckRunPoints = [
        RunPoint(title: "오리런", coordinate: .duckRun, image: "duck"),
        RunPoint(title: "스타트 포인트", coordinate: CLLocationCoordinate2D(latitude: 37.53958, longitude: 127.07435), image: "startpoint")
    ]
    
    var body: some View {
        VStack(spacing: 30) {
            Map(coordinateRegion: $region,
                interactionModes: interactionMode,
                showsUserLocation: true,
                userTrackingMode: $userTracking,
                annotationItems: duckRunPoints,
                annotationContent: { location in
                MapAnnotation(coordinate: location.coordinate) {
                    if location.title == "오리런" {
                        VStack {
                            Image(location.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30)
                            Text(location.title)
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                    } else {
                        VStack {
                            Image(location.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15)
                            Text(location.title)
                                .font(.system(size: 6))
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            })
            .overlay(alignment: .bottomTrailing) {
                HStack {
                    Button {
                        withAnimation {
                            region = MKCoordinateRegion(
                                center: .duckRun,
                                latitudinalMeters: 600,
                                longitudinalMeters: 600
                            )
                        }
                    } label: {
                        Image("duck")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                            .padding(5)
                            .background {
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .foregroundStyle(.yellow)
                                    .shadow(radius: 2)
                            }
                    }
                }
                .padding()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .padding(.horizontal, 30)
        }
        .onAppear {
            locationManager.requestWhenInUseAuthorization()
        }
    }
}


#Preview {
    MapView_iOS16()
}
