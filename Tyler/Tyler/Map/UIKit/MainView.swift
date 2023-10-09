//
//  ContentView-UIKit.swift
//  Tyler
//
//  Created by Hyunjun Kim on 10/9/23.
//

import CoreLocation
import MapKit
import SwiftUI

struct MainView: View {
    
    // 위치 권한 관리
    let locationManager = CLLocationManager()
    
    // Map 표시
    @State private var camera = MKMapCamera(lookingAtCenter: .duckRun, fromDistance: 1300, pitch: 0, heading: -80)
    
    // 맵에 Pin 기능
    @State private var annotations: [AnnotationItem] = [
        AnnotationItem(coordinate: .duckRun, title: "오리런", imageName: "duck"),
        AnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 37.53958, longitude: 127.07435), title: "스타트 포인트", imageName: "startpoint")
    ]
    
    // 맵에 경로 표시
    @State private var coordinates: [CLLocationCoordinate2D] = {
        if let kmlFilePath = Bundle.main.path(forResource: "duckRun", ofType: "kml") {
            let kmlParser = KMLParser()
            return kmlParser.parseKMLFile(atPath: kmlFilePath)
        }
        return []
    }()
    
    // 지도 토글 관련
    @State var isMapChanged = false
    
    // 애니메이션 관련
    @State var currentStep = 0
    @State var timer: Timer?
    
    
    var body: some View {
        VStack(alignment: .leading){
            Text("MapView")
                .bold()
            
            MapView(camera: camera,
                    coordinates: coordinates,
                    annotations: annotations)
            .overlay(alignment: .bottomTrailing) {
                duckButton
            }
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay {
                if isMapChanged {
                    MapUserView()
                        .frame(maxWidth: .infinity)
                        .frame(height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                }
            }
            
            Button(isMapChanged ? "Map User View" : "Map View") {
                isMapChanged.toggle()
            }
            .frame(maxWidth: .infinity)
            .buttonStyle(.bordered)
            
            Text("Map Animation")
                .bold()
            MapAnimationView(camera: camera,
                             coordinates: coordinates,
                             annotations: annotations,
                             currentStep: currentStep)
            .overlay(alignment: .bottomTrailing) {
                duckButton
            }
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            
            Button(currentStep == 0 ? "Animate" : "Animating...") {
                withAnimation {
                    updateCamera()
                    startAnimation()
                }
            }
            .frame(maxWidth: .infinity)
            .buttonStyle(.bordered)
            .disabled(currentStep != 0)
        }
        .onAppear {
            locationManager.requestWhenInUseAuthorization()
        }
        .padding(.horizontal, 30)
    }
    
    private var duckButton: some View {
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
        .padding()
    }
    
    private func updateCamera() {
        withAnimation {
            camera = MKMapCamera(lookingAtCenter: .duckRun, fromDistance: 1300, pitch: 0, heading: -80)
        }
    }
    
    private func startAnimation() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            if currentStep < coordinates.count {
                currentStep += 1
            } else {
                stopAnimation()
                
                /// 경로가 완성 된 후 1초 이후 경로가 사라집니다.
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    currentStep = 0
                }
            }
        }
    }
    
    private func stopAnimation() {
        timer?.invalidate()
        timer = nil
    }
}

struct AnnotationItem: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let title: String
    let imageName: String
}

#Preview {
    MainView()
}
