//
//  CitySearch.swift
//  frontend creation
//
//  Created by Emma Yuan on 2020/8/9.
//  Copyright © 2020 Emma Yuan. All rights reserved.
//
import SwiftUI

//struct City : Identifiable {
//       var id = UUID() // universally unique value
//       var name: String
//   }
//
struct CityRow: View {
       var location: Location

       var body: some View {
        Text(location.getCity())
       }
   }

struct CitySearch: View {
    var body: some View {
    let Locations : [Location] = [Atlanta, Amsterdam, Austin, Beijing, Berlin, Boston, Chicago, London, LosAngeles, Madrid, Miami, Moscow, Mumbai, NewYorkCity, Paris, Phoenix, SanDiego, SanFrancisco, SanJose, Seattle, Seoul, Shanghai, Tokyo, Toronto]

     return NavigationView {
        List(Locations) { location in
            NavigationLink(destination: CurrLoc(location: location)) {
                CityRow(location: location)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("Cities")
          .foregroundColor(Color.blue)
          .font(Font.custom("Copperplate", size: 20))
        }
    }
}

// single row view that represent one single city
struct CityView: View {
    var location: Location

    var body: some View {
        Text(location.getCity())
            .font(.largeTitle)
    }
}

struct CitySearch_Previews: PreviewProvider {
    static var previews: some View {
        CitySearch()
    }
}

