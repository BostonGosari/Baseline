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
        mapView.isUserInteractionEnabled = true
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
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: UIKitMapView
        
        init(_ parent: UIKitMapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let routePolyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: routePolyline)
                renderer.strokeColor = UIColor.orange
                renderer.lineWidth = 3
                renderer.alpha = 0.6
                return renderer
            }
            return MKOverlayRenderer()
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard !(annotation is MKUserLocation) else {
                return nil
            }
            
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
            
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            } else {
                annotationView?.annotation = annotation
            }
            
            switch annotation.title {
            case "오리런":
                annotationView?.image = UIImage(named: "duck")
                let imageSize = CGSize(width: 30, height: 30)
                annotationView?.frame.size = imageSize
                
                let titleLabel = UILabel()
                titleLabel.text = annotation.title ?? ""
                titleLabel.textAlignment = .center
                titleLabel.font = UIFont.systemFont(ofSize: 12)
                titleLabel.frame = CGRect(x: 0, y: imageSize.height, width: imageSize.width * 3, height: 20)
                titleLabel.center = CGPoint(x: annotationView!.bounds.midX, y: annotationView!.bounds.midY + 25)
                annotationView?.addSubview(titleLabel)


            default:
                annotationView?.image = UIImage(named: "startpoint")
                let imageSize = CGSize(width: 20, height: 20)
                annotationView?.frame.size = imageSize
                
                let titleLabel = UILabel()
                titleLabel.text = annotation.title ?? ""
                titleLabel.textAlignment = .center
                titleLabel.font = UIFont.systemFont(ofSize: 10)
                titleLabel.frame = CGRect(x: 0, y: imageSize.height, width: imageSize.width * 3, height: 20)
                titleLabel.center = CGPoint(x: annotationView!.bounds.midX, y: annotationView!.bounds.midY + 20)
                annotationView?.addSubview(titleLabel)
                
            }
            
            annotationView?.clipsToBounds = false
            
            return annotationView
        }
    }
}

#Preview {
    UIKitContentView()
}
