//
//  MapView-UIKit.swift
//  Tyler
//
//  Created by Hyunjun Kim on 10/9/23.
//

import SwiftUI
import MapKit

struct UIKitMapView: UIViewRepresentable {
    
    var camera: MKMapCamera
    var lineCoordinates: [CLLocationCoordinate2D]
    var annotations: [AnnotationItem]
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.camera = camera
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
        view.setCamera(camera, animated: true)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

class Coordinator: NSObject, MKMapViewDelegate {
    var parent: UIKitMapView
    
    init(_ parent: UIKitMapView) {
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

#Preview {
    UIKitContentView()
}
