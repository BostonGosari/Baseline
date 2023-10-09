//
//  ContentView-UIKit.swift
//  Tyler
//
//  Created by Hyunjun Kim on 10/9/23.
//

import CoreLocation
import MapKit
import SwiftUI

struct AnnotationItem: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let title: String
    let imageName: String
}

struct UIKitContentView: View {
    
    let locationManager = CLLocationManager()
    
    @State private var camera = MKMapCamera(lookingAtCenter: .duckRun, fromDistance: 1300, pitch: 0, heading: -80)
        
    @State private var annotations: [AnnotationItem] = [
        AnnotationItem(coordinate: .duckRun, title: "오리런", imageName: "duck"),
        AnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 37.53958, longitude: 127.07435), title: "스타트 포인트", imageName: "startpoint")
    ]
    
    @State private var lineCoordinates = [
        CLLocationCoordinate2D(latitude: 37.53958, longitude: 127.07435),
        CLLocationCoordinate2D(latitude: 37.54132, longitude: 127.07575),
        CLLocationCoordinate2D(latitude: 37.54233, longitude:  127.07631),
        CLLocationCoordinate2D(latitude: 37.54215, longitude: 127.07750),
        CLLocationCoordinate2D(latitude: 37.53936, longitude: 127.07687),
        CLLocationCoordinate2D(latitude: 37.53958, longitude: 127.07435)
    ];
    
    var body: some View {
        VStack {
            UIKitMapView(
                camera: camera,
                lineCoordinates: lineCoordinates, 
                annotations: annotations
            )
            .overlay(alignment: .bottomTrailing) {
                HStack {
                    Button {
                        updateCamera()
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
            
            UIKitMapUserView(lineCoordinates: lineCoordinates, annotations: annotations)
                .frame(maxWidth: .infinity)
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .padding(.horizontal, 30)
        }
        .onAppear {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func updateCamera() {
        withAnimation {
            camera = MKMapCamera(lookingAtCenter: .duckRun, fromDistance: 1300, pitch: 0, heading: -80)
        }
    }
}


#Preview {
    UIKitContentView()
}
