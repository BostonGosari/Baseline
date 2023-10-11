//
//  MapView.swift
//  Helia
//
//  Created by hyebin on 10/10/23.
//

import CoreLocation
import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    @State private var userLocations: [CLLocationCoordinate2D] = []
    
    @Binding var isTracking: Bool
    @Binding var locationManager: CLLocationManager
    
    let mapView = MKMapView()
    
    func makeUIView(context: Context) -> MKMapView {
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeOverlays(uiView.overlays)
        
        if !userLocations.isEmpty {
            let polyline = MKPolyline(coordinates: userLocations, count: userLocations.count)
            uiView.addOverlay(polyline)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
            if let userLocation = mapView.userLocation.location {
                let region = MKCoordinateRegion(
                    center: userLocation.coordinate,
                    latitudinalMeters: 500,
                    longitudinalMeters: 500
                )
                mapView.setRegion(region, animated: true)
            }
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: polyline)
                renderer.strokeColor = .orange
                renderer.lineWidth = 7
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.last?.coordinate {
                parent.userLocations.append(location)
            }
        }
    }
}
