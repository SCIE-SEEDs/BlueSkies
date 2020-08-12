//
//  CitySearch.swift
//  frontend creation
//
//  Created by Emma Yuan on 2020/8/9.
//  Copyright © 2020 Emma Yuan. All rights reserved.
//

import SwiftUI

struct CitySearch: View {
    @State private var searchTerm: String = ""
    let cityNames = ["Los Angeles", "San Diego", "San Francisco"]
    
//    let majorCities = {
//        "San Francisco": ["California", "US"],
//        "San Diego": ["California", "US"],
//        "Boston": ["Massachusetts", "US"],
//        "Amsterdam": ["North Holland", "Netherlands"],
//        "Shanghai": ["", "China"],
//        "Moscow": ["", "Russia"],
//        "Toronto": ["", "Canada"],
//        "Melbourne": ["", "Australia"],
//        "Madrid": ["", "Spain"],
//        "Berlin": ["", "Germany"],
//        "Seoul": ["", "South Korea"],
//        "Brussels": ["", "Belgium"],
//        "Sydney": ["", "Australia"],
//        "Washington D.C.": ["", "Australia"],
//        "Beijing": ["", "China"],
//        "Chicago": ["Illinois", "US"],
//        "Los Angeles": ["California", "US"],
//        "Hong Kong": ["", "China"],
//        "Tokyo": ["", "Japan"],
//        "Paris": ["", "France"],
//        "London": ["", "London"],
//        "New York City": ["New York", "US"],
//    }
//    let cities = Array(majorCities.allKeys)

    /*https://www.businessinsider.com/most-influential-cities-in-the-world-2018-5#1-new-york-city-new-york-21 */
    
    var body: some View {
        List{
            SearchBar(text: $searchTerm)
            
            ForEach(self.cityNames.filter{
                self.searchTerm.isEmpty ? true : $0.localizedCaseInsensitiveContains(self.searchTerm)
            }, id: \.self){ city in
                Text(city)
            }
        }
        .navigationBarTitle(Text("Where could I breath?")
            .foregroundColor(Color.black)
            .font(Font.custom("Copperplate", size: 40))
        )
        
        .foregroundColor(Color.black)
        .font(Font.custom("Futura-Medium", size: 18))
    }
}

struct CitySearch_Previews: PreviewProvider {
    static var previews: some View {
        CitySearch()
    }
}
