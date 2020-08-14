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

        let Maps : [Location] = [Atlanta, Amsterdam, Austin, Beijing, Berlin, Boston, Chicago, London, LosAngeles, Madrid, Miami, Moscow, Mumbai, NewYorkCity, Paris, Phoenix, SanDiego, SanFrancisco, SanJose, Seattle, Seoul, Shanghai, Tokyo, Toronto]
        
        var MKPoints : [MKPointAnnotation] = []
        
        for city in Maps {
            let placeHolder = MKPointAnnotation()
            if (city.getAQI() < 0) {
                city.resetAQI()
            }
            placeHolder.title = String(city.getAQI())
            if (placeHolder.title == "-1") {
                placeHolder.title = "Loading..."
            }
            placeHolder.subtitle = city.getCity()
            placeHolder.coordinate = CLLocationCoordinate2D(latitude: city.getCoordinates()[0], longitude: -city.getCoordinates()[1])
            Map.addAnnotation(placeHolder)
            MKPoints.append(placeHolder)
        }
       
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
