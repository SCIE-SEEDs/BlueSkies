//
//  Map.swift
//  frontend creation
//
//  Created by Emma Yuan on 2020/8/9.
//  Copyright © 2020 Emma Yuan. All rights reserved.
//

import SwiftUI
import MapKit

struct Map: UIViewRepresentable {
    
    class Coordinator : NSObject, MKMapViewDelegate {
        var parent : Map
        init(_ parent : Map){
            self.parent = parent
        }
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            print(mapView.centerCoordinate)
        }
        func Map(_ Map: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            view.canShowCallout = true
            return view
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let Map = MKMapView()
        Map.delegate = context.coordinator
        

        
        let SanFrancisco = MKPointAnnotation()
        SanFrancisco.title = "100"
        SanFrancisco.subtitle = "San Francisco"
        SanFrancisco.coordinate = CLLocationCoordinate2D(latitude: Phoenix.getCoordinates()[0], longitude: -Phoenix.getCoordinates()[1])
        Map.addAnnotation(SanFrancisco)
        
        let LosAngeles = MKPointAnnotation()
        LosAngeles.title = "200"
        LosAngeles.subtitle = "Los Angeles"
        LosAngeles.coordinate = CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437)
        Map.addAnnotation(LosAngeles)
        
        let SanDiego = MKPointAnnotation()
        SanDiego.title = "100"
        SanDiego.subtitle = "San Diego"
        SanDiego.coordinate = CLLocationCoordinate2D(latitude: 32.7157, longitude: -117.1611)
        Map.addAnnotation(SanDiego)

        return Map
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
    }
}

struct Map_Previews: PreviewProvider {
    static var previews: some View {
        Map()
    }
}
