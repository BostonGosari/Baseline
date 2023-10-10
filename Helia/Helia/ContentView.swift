//
//  ContentView.swift
//  Helia
//
//  Created by Hyunjun Kim on 10/5/23.
//

import CoreLocation
import SwiftUI

struct ContentView: View {
    @State private var isTracking = false
    @State private var locationManager = CLLocationManager()
    
    var body: some View {
        ZStack {
            MapView(isTracking: $isTracking, locationManager: $locationManager)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                playButton
            }
        }
        .onAppear {
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

extension ContentView {
    private var playButton: some View {
        Button {
            isTracking.toggle()
            
            if isTracking {
                locationManager.startUpdatingLocation()
            }else {
                locationManager.stopUpdatingLocation()
            }
        } label: {
            Image(systemName: isTracking ? "pause.circle.fill" : "play.circle.fill")
                .tint(Color.black)
                .font(.system(size: 50))
        }
    }
}

#Preview {
    ContentView()
}
