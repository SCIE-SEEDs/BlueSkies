//
//  API.swift
//  Wireframe
//
//  Created by Serina Khanna on 8/3/20.
//  Copyright © 2020 Serina Khanna. All rights reserved.
//

import Foundation

struct smogIndex: Codable {
    var results: BooleanLiteralType
    var city: String
    var state: String
    var country: String
    var type: [Double]
}

func fetchSmogSpecifiedCityinput(city: String, state: String, country: String, completion: (_ result: String) -> Void) {
    var newCity = city
    var newState = state
    
    while let firstSpace = newCity.firstIndex(of: " ") {
        newCity = newCity.prefix(upTo: firstSpace) + "%20" + newCity.suffix(from: firstSpace)
    }
    while let firstSpace = newState.firstIndex(of: " ") {
        newState = newState.prefix(upTo: firstSpace) + "%20" + newState.suffix(from: firstSpace)
    }
    
    let semaphore = DispatchSemaphore (value: 0)
    
    let stringURL = "http://api.airvisual.com/v2/city?city=\(newCity)&state=\(newState)&country=\(country)&key=55593aa1-c351-45bf-975a-9c687b2b1ecb"
    //"http://api.airvisual.com/v2/city?city=Los%20Angeles&state=California&country=USA&key=55593aa1-c351-45bf-975a-9c687b2b1ecb"

    var request = URLRequest(url: URL(string: stringURL)!,timeoutInterval: Double.infinity)
    request.httpMethod = "GET"

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data else {
        print(String(describing: error))
        return
      }
      print(String(data: data, encoding: .utf8)!)
      semaphore.signal()
    }

    task.resume()
    semaphore.wait()
}

func fetcherData(city: String, state: String, country: String) -> Void {
    fetchSmogSpecifiedCityinput(city: "Los Angeles", state: "California", country: "USA") {
        (result: String) in
        //let data = result
            print(result)
    }
}




/*

func fetchSmogSpecifiedCityinput(input: String, completion: (result: String) -> Void) {
    let urlString = "http://api.airvisual.com/v2/city?city=Los Angeles&state=California&country=USA&key={{55593aa1-c351-45bf-975a-9c687b2b1ecb}}"
    
    if let url = URL(string: urlString) {
        URLSession.shared.dataTask(with: url) { data, res, err in
            if let data = data {
                print("good.")
                
                let decoder = JSONDecoder()
                if let json = try? decoder.decode(smogIndex.self, from: data) {
                    completion(json)
                }
            }
            else {
                print("error found fetching specified city.")
            }
        }//.resume()
        print("finished")
    } else {
        print("URL does not work.")
    }
 
}

*/
