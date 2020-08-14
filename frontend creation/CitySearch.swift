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

    var body: some View {
        List{
            SearchBar(text: $searchTerm)
            
            ForEach(self.cityNames.filter{
                self.searchTerm.isEmpty ? true : $0.localizedCaseInsensitiveContains(self.searchTerm)
            }, id: \.self){ city in
                Text(city)
            }
        }
        .navigationBarTitle(Text("Where can I breathe?")
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
