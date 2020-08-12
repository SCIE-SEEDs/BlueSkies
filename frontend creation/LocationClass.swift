//
//  LocationClass.swift
//  frontend creation
//
//  Created by Serina Khanna on 8/11/20.
//  Copyright © 2020 Emma Yuan. All rights reserved.
//
/** DOCUMENTATION!!!
 *
 * Please assume all are default open access (public) unless otherwise specified.
 * Access Levels (for reference)
    * Open access and public access -->
        * Can be used within any source file outside or inside module.
        * Can be used from module that imports class.
        * Dif. b/t open and public is about child classes - not applicable here
    * Internal access -->
        * Entities can be used within any source file not their defining class, but not any source file outside of module.
    * File-private access -->
        * Restricts the use of an entity to its own defining source file.
        * Use to hide implementation details
    * Private access -->
        * Restricts the use of an entity to the enclosing declaration, and to extensions of that declaration that are in the same file.
        * Good to hide implementation of functionality that is used ONCE
 *
 * class Location () --> stores the information for all of the places used by the app
 *
 * Variables (all are FILE-PRIVATE - please use setter/getter methods to access)
    * var city : String --> a String that stores the city
    * var state : String --> a String that stores the state
    * var country : String --> a String that stores the country
    * var coordinates : [Double] --> a Double array ( [Double] ) that stores 2 coordinates. There should be no more than 2 elements
    * var aqi : Int --> an Int that stores the Air Quality Index (US standards).
        * Cannot be manually changed. Is first created upon initialization by fetchAQI().
        * Updated whenever resetAQI() or getAQI() or fetchAQI() is called.
 *
 * Constructors (PUBLIC)
    * init() --> Void
        * Takes 0 parameters. default values assigned for all.
    * init(city: String, state: String, country: String, coordinates: [Double])  -> Void
        * Takes the city, state, country, and coordinates parameters.
        * Calls fetchAQI() to determine the aqi value.
    * EXAMPLE:
        * var a = Location()
        * var a = Location(city: "Austin", state: "Texas", country: "USA", coordinates: [-97.760002, 30.3542])
 *
 * Methods (General) (FILE-PRIVATE)
    * FILE-PRIVATE fetchAQI() -> Void
        * If you want to change the aqi, call resetAQI(). If you want to reset + get aqi, then call getAQI().
        * Calls fetchSmogSpecifiedCityInput() to recieve JSON information, then manually sorts through the information and searches for the aqi
    * FILE-PRIVATE fetchSmogSpecifiedCityInput(city: String, state: String, country: String, completion: @escaping (_ result: String) -> Void)
        * Fetches the JSON information from API and returns as a String
        * Uses completion handler, so must use this format to get result:
            * fetchSmogSpecifiedCityInput(city: self.city, state: self.state, country: self.country) {
                (result: String) in
                *insert code here*
 *
 * Methods (Getter) (PUBLIC)
    * getCity() -> String
        * Returns city
    * getState() -> String
        * Returns state
    * getCountry() -> String
        * Returns country
    * getCoordinates() -> [Double]
        * Returns coordinates as a [Double]
    * getAQI() -> Int
        * Public method! Please use this one instead of fetchAPI()
        * Calls resetAQI() and then returns newly found aqi as an Int
 *
 * Methods (Setter) (PUBLIC)
    * setCity(city : String) -> Void
        * Sets the new city
    * setState(state : String) -> Void
        * Sets the new state
    * setCountry(country : String) -> Void
        * Sets the new country
    * setCoordinates( coordinates : [Double] ) -> Void
        * Sets the new coordinates
    * resetAQI() -> Void
        * Public
        * Does not take in any parameters
        * Instead calls the API function to reset the aqi
        * If want to reset AQI whenever user needs to, please use the getAQI(), since it returns value and automatically calls resetAQI()
 */

import Foundation

//
//  API.swift
//  Wireframe
//
//  Created by Serina Khanna on 8/3/20.
//  Copyright © 2020 Serina Khanna. All rights reserved.
//

import Foundation

class Location {
   // var id: Int
    var city: String
    var state: String
    var country: String
    var coordinates: [Double]
    var aqi: Int
    
    init() {
        city = ""
        state = ""
        country = "USA"
        coordinates = []
        aqi = 0
    }
    
    /**
      * Constructor for city, state, and country. Calls fetchData for coordinates + aqi
      * @param city the city
     * @param state the state
     * @param country the country
    */
    init(city: String, state: String, country: String) {
        self.city = city
        self.state = state
        self.country = country
        coordinates = []
        aqi = 0
        fetchData()
    }
    
    /**
      * Fetches the data & assigns the values to coordinates and aqi
    */
    func fetchData() -> Void {
        fetchSmogSpecifiedCityInput(city: self.city, state: self.state, country: self.country) {
            (result: String) in
            //print(result)
            self.coordinates = stringSearcherCoordinates(result: result)
            print("Found coordinates: \(self.coordinates)")
            //self.aqi = stringSearcherAQI(result: result)
        }
    }

    func insertCoordinates(coordinates: [Double]) -> Void {
      self.coordinates = coordinates;
    }
}

/**
 * Fetches the unfiltered JSON data
 * @param city the city to search for
 * @param state the state to search for
 * @param country the country to search within
 * @completion the completion handler that returns String of JSON data
*/
func fetchSmogSpecifiedCityInput(city: String, state: String, country: String, completion: @escaping (_ result: String) -> Void) {
    var newCity = city
    var newState = state

    //ASK ANNA
    if let firstSpace = newCity.firstIndex(of: " ") {
        newCity = newCity.prefix(upTo: firstSpace) + "%20" + newCity.suffix(from: firstSpace)
    }
    if let firstSpace = newState.firstIndex(of: " ") {
        newState = newState.prefix(upTo: firstSpace) + "%20" + newState.suffix(from: firstSpace)
    }
    
    print(newCity)
    print(newState)

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
      completion(String(data: data, encoding: .utf8)!)
      semaphore.signal()
    }

    task.resume()
    semaphore.wait()
}

/**
  * Returns the coordinates given the JSON data
  * @param result The unfiltered JSON data returned by fetchSmogSpecifiedCityInput()
  * @return an array of doubles (2 values returned) containing the coordinates
*/
func stringSearcherCoordinates(result: String)  -> ([Double]) {
    
   // let str = "abcde"
    var substring = ""
    if let range = result.range(of: "coordinates\":[")  { //"cd"
        substring = String(result[range.upperBound...])
        if let range = substring.range(of: "]}") {
            substring = String(substring[...range.lowerBound])
        //print(substring)
        }
    }
    
    //substring is good
    //print(substring)
    let array = (substring.components(separatedBy: ","))
    //print(array)
    //print(array2)

    let double1 : Double = Double(array[0])!
    let double2 : Double = Double( array[1].components(separatedBy: "]")[0] )!


    //ASK ANNA
    return [double1, double2]
}
/*
    if ​let double1 = Double(array[0]) {
        print(double1)
    }
    else {
      print("Unable to convert array to double")
      return []
    }
    //print(double1)
    return []
}

    guard​ ​let​ double2 = Double(array2) else {
      print("Unable to convert array to double")
      return
    }

    return ( [ double1, double2 ] )//, array2] )
}
*/

/**
  * Returns the AQI given the data
  * @param result The unfiltered JSON data returned by fetchSmogSpecifiedCityInput()
  * @return an array of doubles (2 values returned) containing the coordinates
*/

/*
func stringSearcherAQI(result: String)  -> Int {
    
   // let str = "abcde"
    var substring = ""
    if let range = result.range(of: "aqius\":")  { //"cd"
        substring = String(result[range.upperBound...])
        print(substring)
    }

    let array = Int(substring.components(separatedBy: ",")[0])!
    return array
}

*/
