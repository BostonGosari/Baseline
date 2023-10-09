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

struct MainView: View {
    
    let locationManager = CLLocationManager()
    
    @State private var camera = MKMapCamera(lookingAtCenter: .duckRun, fromDistance: 1300, pitch: 0, heading: -80)
    
    @State private var annotations: [AnnotationItem] = [
        AnnotationItem(coordinate: .duckRun, title: "오리런", imageName: "duck"),
        AnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 37.53958, longitude: 127.07435), title: "스타트 포인트", imageName: "startpoint")
    ]
    
    @State private var coordinates: [CLLocationCoordinate2D] = {
        if let kmlFilePath = Bundle.main.path(forResource: "duckRun", ofType: "kml") {
            let kmlParser = KMLParser()
            return kmlParser.parseKMLFile(atPath: kmlFilePath)
        }
        return []
    }()
    
    @State var isMapChanged = false
    @State var currentStep = 0
    @State var timer: Timer?
    
    
    var body: some View {
        VStack {
            Text("MapView")
            MapView(
                camera: camera,
                coordinates: coordinates,
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
            .overlay {
                if isMapChanged {
                    MapUserView()
                        .frame(maxWidth: .infinity)
                        .frame(height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .padding(.horizontal, 30)
                }
            }
            Button(isMapChanged ? "Map User View" : "Map View") {
                withAnimation {
                    isMapChanged.toggle()
                }
            }
            .buttonStyle(.bordered)
            
            Text("Map Animation")
            MapAnimationView(camera: camera, coordinates: coordinates, annotations: annotations, currentStep: currentStep)
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
            Button(currentStep == 0 ? "Animate" : "Animating...") {
                withAnimation {
                    startAnimation()
                }
            }
            .buttonStyle(.bordered)
            .disabled(currentStep != 0)
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
    
    // 애니메이션 시작
    private func startAnimation() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { _ in
            if currentStep < coordinates.count {
                currentStep += 1
            } else {
                stopAnimation()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    currentStep = 0
                }
            }
        }
    }
    
    // 애니메이션 정지
    private func stopAnimation() {
        timer?.invalidate()
        timer = nil
    }
}



#Preview {
    MainView()
}
