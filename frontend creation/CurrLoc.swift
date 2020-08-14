//
//  CurrLoc.swift
//  frontend creation
//
//  Created by Emma Yuan on 2020/8/10.
//  Copyright © 2020 Emma Yuan. All rights reserved.
//

import SwiftUI

struct CurrLoc: View {
    @State var location : Location
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var AQI: Int {
        return location.getAQI()
    }
    
    @State var temp = 3
    @State var hum = 2
    @State var wind = 3
    @State var Cunit = true
    
    func feedback () -> String {
        var level = ""
        if AQI < 50 {
            level = "Good"
        } else if AQI < 100 {
            level = "Moderate"
        } else if AQI < 150 {
            level = "Unhealthy for Sensitive Groups"
        } else if AQI < 200 {
            level = "Unhealthy"
        } else if AQI < 300 {
            level = "Very Unhealthy" + "\n" + "Please Wear Mask"
        } else {
            level = "Hazardous"
        }
        return level
    }
    
    func CtoF () -> Int {
        if !Cunit {
            temp = (temp * 9/5) + 32
        }
        return temp
    }
    
    struct TitleStyle: ViewModifier {
        func body (content: Content) -> some View {
            return content
                .foregroundColor(Color.white)
                .font(Font.custom("Copperplate", size: 30))
                .multilineTextAlignment(.center)
        }
    }
    
    struct TextStyle: ViewModifier {
        func body (content: Content) -> some View {
            return content
                .foregroundColor(Color.white)
                .font(Font.custom("Copperplate", size: 18))
                .multilineTextAlignment(.center)
        }
    }
    
//    var btnBack : some View { Button(action: {
//        self.presentationMode.wrappedValue.dismiss()
//        }) {
//            HStack {
//                Image(systemName: "cheveron.left")
//                Text("\(location.getCity())")
//            }
//        }
//    }
    
    struct NumStyle: ViewModifier {
        func body (content: Content) -> some View {
            return content
            .colorInvert()
                .frame(width: 40, height: 40)
        }
    }
    
    var body: some View {
        // self.navigationItem.title = "\(location.getCity())"
        VStack { // "Very Unhealthy" + "\n" + "Please Wear Mask"
            Text("Panic Height in" + "\n" + "\(location.getCity())").modifier(TitleStyle())
            Spacer()
            Text("\(AQI)")
                .foregroundColor(Color.white)
                .font(Font.custom("Copperplate", size: 40))
                .background(Circle()
                    .frame(width: 150.0, height: 150.0)
            )
            Spacer()
            Text("\(feedback())").modifier(TextStyle())
                .padding(.bottom, 40)
            
            HStack {
                Spacer()
                VStack{
                    Text("\(CtoF())")
                        .background(Circle().modifier(NumStyle()))
                        .padding(.bottom, 20)
                    Text("temp").modifier(TextStyle())
                }
                Spacer()
                VStack{
                    Text("\(hum)")
                        .background(Circle().modifier(NumStyle()))
                        .padding(.bottom, 20)
                    Text("hum").modifier(TextStyle())
                }
                Spacer()
                VStack{
                    Text("\(wind)")
                        .background(Circle().modifier(NumStyle()))
                        .padding(.bottom, 20)
                    Text("wind").modifier(TextStyle())
                }
                Spacer()
            }

            Toggle(isOn: $Cunit) {
                Text("celsius").modifier(TextStyle())
            }.padding(.horizontal, 100).multilineTextAlignment(.center)

            Spacer()
        }
        .background(Image("background"))
   // .navigationBarBackButtonHidden(true)
   // .navigationBarItems(leading: btnBack)
    //.navigationBarBackButtonHidden(true)
    //.navigationBarHidden(true)
    }
}

struct CurrLoc_Previews: PreviewProvider {
    static var previews: some View {
        CurrLoc(location: SanDiego)
    }
}
