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
            Text("Let's find")
                .bold()
                .foregroundColor(Color.white)
                .font(Font.custom("Copperplate", size: 30))
            .padding(.top, 75)

            Text("blue skies")
                .bold()
                .foregroundColor(Color.white)
                .font(Font.custom("Copperplate", size: 40))
                .padding(.bottom, 50)
            Text(PositiveMessagesArray.randomElement()!)
            .bold()
                .background(RoundedRectangle(cornerRadius: 5).fill(Color.white).opacity(0.3))
            .foregroundColor(Color.white)
            .font(Font.custom("Futura-Medium", size: 20))
            .padding(.bottom, 100)
            .multilineTextAlignment(.center)

            NavigationLink(destination: HomeView()) {
                Text("Get Started")
                    .foregroundColor(Color.black)
                    .font(Font.custom("Futura-Medium", size: 20))
            }.background(Image("button"))
                .padding(.bottom, 100)
        }
        .background(Image("background"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
