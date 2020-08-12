//
//  HomeView.swift
//  frontend creation
//
//  Created by Emma Yuan on 2020/8/9.
//  Copyright © 2020 Emma Yuan. All rights reserved.
//

import SwiftUI

struct HomeView: View {
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
                Text("Curr Loc").modifier(Button())
            }.background(Image("Button"))
            NavigationLink(destination: CitySearch()) {
                Text("City Search").modifier(Button())
            }.background(Image("Button"))
            NavigationLink(destination: Explore()) {
                Text("Explore").modifier(Button())
            }.background(Image("Button"))
        }
        .background(Image("Background"))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
