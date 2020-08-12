//
//  ContentView.swift
//  frontend creation
//
//  Created by Emma Yuan on 2020/8/9.
//  Copyright © 2020 Emma Yuan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Let's get you")
                .bold()
                .foregroundColor(Color.white)
                .font(Font.custom("Copperplate", size: 30))
            Text("breathing!")
                .bold()
                .foregroundColor(Color.white)
                .font(Font.custom("Copperplate", size: 40))
                .padding(.bottom, 150)
            NavigationLink(destination: HomeView()) {
                Text("Get Started")
                    .foregroundColor(Color.black)
                    .font(Font.custom("Futura-Medium", size: 20))
            }.background(Image("Button"))
        }
        .background(Image("Background"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
