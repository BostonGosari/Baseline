//
//  UserPathView.swift
//  Helia
//
//  Created by hyebin on 10/11/23.
//

import CoreLocation
import SwiftUI

struct UserPathView: View {
    @State private var isTracking = false
    @State private var locationManager = CLLocationManager()
    
    var body: some View {
        ZStack {
            MapView(isTracking: $isTracking, locationManager: $locationManager)
                .scaledToFill()
            
            VStack {
                Spacer()
                playButton
            }
            .padding(.bottom, 10)
        }
        .padding(.bottom, 10)
        .onAppear {
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

extension UserPathView {
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
    UserPathView()
}
