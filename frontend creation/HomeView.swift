//
//  HomeView.swift
//  frontend creation
//
//  Created by Emma Yuan on 2020/8/9.
//  Copyright © 2020 Emma Yuan. All rights reserved.
//

import SwiftUI
import MapKit
import CoreLocation

struct HomeView: View {
    @ObservedObject var locationManager = LocationManager()

    var userLatitude: String {
        return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
    }

    var userLongitude: String {
        return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
    }
    
    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?)
                    -> Void ) {
        // Use the last reported location.
        if let lastLocation = self.locationManager.lastLocation {
            let geocoder = CLGeocoder()
                
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation,
                        completionHandler: { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?[0]
                    completionHandler(firstLocation)
                }
                else {
                 // An error occurred during geocoding.
                    completionHandler(nil)
                }
            })
        }
        else {
            // No location was available.
            completionHandler(nil)
        }
    }
    
    struct Button: ViewModifier {
           func body (content: Content) -> some View {
               return content
                    .foregroundColor(Color.black)
                    .font(Font.custom("Futura-Medium", size: 20))
                    .padding(50)
           }
       }
    
    var body: some View {
        VStack {
            NavigationLink(destination: CurrLoc()) {
                Text("Current City").modifier(Button())
            }.background(Image("button"))
            NavigationLink(destination: CitySearch()) {
                Text("City Search").modifier(Button())
            }.background(Image("button"))
            NavigationLink(destination: Explore()) {
                Text("Explore").modifier(Button())
            }.background(Image("button"))
            VStack {
                Text("location status: \(locationManager.statusString)")
                HStack {
                    Text("latitude: \(userLatitude)")
                    Text("longitude: \(userLongitude)")
                }
            }
        }
        .background(Image("background"))
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
