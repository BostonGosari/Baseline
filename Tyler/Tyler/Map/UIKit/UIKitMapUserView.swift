//
//  UIKitMapUserView.swift
//  Tyler
//
//  Created by Hyunjun Kim on 10/9/23.
//

import SwiftUI
import MapKit

struct UIKitMapUserView: UIViewRepresentable {
    var lineCoordinates: [CLLocationCoordinate2D]
    var annotations: [AnnotationItem]
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.camera = MKMapCamera()
        
        mapView.userTrackingMode = .followWithHeading
        mapView.isUserInteractionEnabled = false
        mapView.showsUserLocation = true
        
        let polyline = MKPolyline(coordinates: lineCoordinates, count: lineCoordinates.count)
        mapView.addOverlay(polyline)
        
        for annotation in annotations {
            let pointAnnotation = MKPointAnnotation()
            pointAnnotation.coordinate = annotation.coordinate
            pointAnnotation.title = annotation.title
            mapView.addAnnotation(pointAnnotation)
        }
        
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: UIKitMapUserView
        
        init(_ parent: UIKitMapUserView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let routePolyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: routePolyline)
                renderer.strokeColor = UIColor.orange
                renderer.lineWidth = 4
                renderer.alpha = 0.7
                return renderer
            }
            return MKOverlayRenderer()
        }
    }
}

#Preview {
    UIKitContentView()
}
