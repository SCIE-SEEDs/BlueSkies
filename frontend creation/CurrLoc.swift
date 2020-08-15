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
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var AQI: Int {
        return location.getAQI()
    }
    
    @State var temp = 3
    @State var hum = 2
    @State var wind = 3
    @State var Cunit = true
    
    func feedback () -> [String]{
           var feedback = ["", ""]
           if AQI < 50 {
                feedback[0] = "Good"
                feedback[1] = "enjoy your day :))"
           } else if AQI < 100 {
                feedback[0] = "Moderate"
                feedback[1] = "Some pollutants there may be a moderate health concern for a very small number of people"
           } else if AQI < 150 {
               feedback[0] = "Unhealthy for Sensitive Groups"
                feedback[1] = "Members of sensitive groups (lung or heart disease) may experience health effects"
           } else if AQI < 200 {
               feedback[0] = "Unhealthy"
                feedback[1] = "Everyone may begin to experience health effects"
           } else if AQI < 300 {
               feedback[0] = "Very Unhealthy"
                feedback[1] = "Everyone may experience more serious health effects"
           } else {
               feedback[0] = "Hazardous"
                feedback[1] = "Please Stay Indoors"
           }
           return feedback
       }
    
//    func CtoF () -> Int {
//        if !Cunit {
//            temp = (temp * 9/5) + 32
//        }
//        return temp
//    }
    
    struct TitleStyle: ViewModifier {
        func body (content: Content) -> some View {
            return content
                .foregroundColor(Color.white)
                .font(Font.custom("Copperplate", size: 30))
                .multilineTextAlignment(.center)
        }
    }
    
    struct LevelStyle: ViewModifier {
        func body (content: Content) -> some View {
            return content
                .foregroundColor(Color.white)
                .font(Font.custom("Copperplate", size: 22))
                .multilineTextAlignment(.center)
        }
    }
    
    struct AdviseStyle: ViewModifier {
        func body (content: Content) -> some View {
            return content
                .foregroundColor(Color.white)
                .font(Font.custom("Futura-Medium", size: 18))
                .multilineTextAlignment(.center)
        }
    }
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "cheveron.left")
                Text("\(location.getCity())")
            }
        }
    }
    
//    struct NumStyle: ViewModifier {
//        func body (content: Content) -> some View {
//            return content
//            .colorInvert()
//                .frame(width: 40, height: 40)
//        }
//    }
    
    var body: some View {
        // self.navigationItem.title = "\(location.getCity())"
        VStack { // "Very Unhealthy" + "\n" + "Please Wear Mask"
            Text("Air Quality").modifier(TitleStyle())
            Spacer()
            Text("\(AQI)")
                .foregroundColor(Color.white)
                .font(Font.custom("Copperplate", size: 40))
                .background(Circle()
                    .frame(width: 150.0, height: 150.0)
            )
            Spacer()
            Text("\(feedback()[0])").modifier(LevelStyle())
                .padding(.bottom, 20)
            Text("\(feedback()[1])").modifier(AdviseStyle())
                .padding(.bottom, 40)
            
            
//            HStack {
//                Spacer()
//                VStack{
//                    Text("\(CtoF())")
//                        .background(Circle().modifier(NumStyle()))
//                        .padding(.bottom, 20)
//                    Text("temp").modifier(TextStyle())
//                }
//                Spacer()
//                VStack{
//                    Text("\(hum)")
//                        .background(Circle().modifier(NumStyle()))
//                        .padding(.bottom, 20)
//                    Text("hum").modifier(TextStyle())
//                }
//                Spacer()
//                VStack{
//                    Text("\(wind)")
//                        .background(Circle().modifier(NumStyle()))
//                        .padding(.bottom, 20)
//                    Text("wind").modifier(TextStyle())
//                }
//                Spacer()
//            }
//
//            Toggle(isOn: $Cunit) {
//                Text("celsius").modifier(TextStyle())
//            }.padding(.horizontal, 100).multilineTextAlignment(.center)

            Spacer()
        }
        .background(Image("background"))
   .navigationBarBackButtonHidden(true)
   .navigationBarItems(leading: btnBack)
    //.navigationBarBackButtonHidden(true)
    //.navigationBarHidden(true)
    }
}

struct CurrLoc_Previews: PreviewProvider {
    static var previews: some View {
        CurrLoc(location: SanDiego)
    }
}
