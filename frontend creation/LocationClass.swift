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
        * Calls stringByAddingPercentEncodingForRFC3986(), which is located in StringExtension, to fit URL Encoding Standard
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

//
//  API.swift
//  Wireframe
//
//  Created by Serina Khanna on 8/3/20.
//  Copyright © 2020 Serina Khanna. All rights reserved.
//

import Foundation

class Location : Identifiable {
   // var id: Int
    fileprivate var city: String
    fileprivate var state: String
    fileprivate var country: String
    fileprivate var coordinates: [Double]
    fileprivate var aqi: Int

    fileprivate let keys : [String] = ["a21ac2ea-e689-4db1-92dd-71e4800c5e48", "55593aa1-c351-45bf-975a-9c687b2b1ecb", "aea612ff-0a4f-41a8-af81-117b1db13615", "55adb354-0305-448d-bb3a-37459c538aa4", "62f1c45e-a6bc-49d0-80c6-bff249ce77c7", "6c0a8ae2-7a37-44e5-b5cd-0e4bed500e13"]
    
    public init() {
        city = ""
        state = ""
        country = "USA"
        coordinates = []
        aqi = -1
    }
    
    /**
      * Constructor for city, state, and country. Calls fetchData for coordinates + aqi
      * @param city the city
     * @param state the state
     * @param country the country
    */
    public init(city: String, state: String, country: String, coordinates: [Double]) {
        self.city = city
        self.state = state
        self.country = country
        self.coordinates = coordinates
        self.aqi = -1
        fetchData()
    }
    
    /**
      * Fetches the data & assigns the values to aqi
    */
    fileprivate func fetchData() -> Void {
        var jsonData: Data?
        var dictionary : [String: Any]
        var json : Any?
        //key1
        for keye in keys {
            print("attempting \(keye)")
            fetchSmogSpecifiedCityInput(city: self.city, state: self.state, country: self.country, key: keye ) {
                (result: String) in
                //fetches the aqi info
                jsonData = result.data(using: .utf8)!
                print(result)
            }
            json = try? JSONSerialization.jsonObject(with: jsonData!, options: [])
            dictionary = (json as? [String: Any] )!
            if (dictionary["status"]! as? String)! != "fail" {
                print("success! found info")
                break
            }
        }
        dictionary = (json as? [String: Any] )!
        
        if (dictionary["status"]! as? String)! != "fail" {
          let data = (dictionary["data"]! as? [String: Any])!
          let current = (data["current"]! as? [String: Any])!
          let pollution = (current["pollution"]! as? [String: Any])!
          self.aqi = pollution["aqius"]! as! Int
          print("success for \(self.city)")
        }
        //three times fail :/
        else {
          print("fail for \(self.city)")
            //print(dictionary)
            //no change to aqi, incase already a valid value
            //:/
            //put some sort of error msg?
        }
        
    }

    /**
     * Fetches the unfiltered JSON data
     * @param city the city to search for
     * @param state the state to search for
     * @param country the country to search within
     * @completion the completion handler that returns String of JSON data
    */
    fileprivate func fetchSmogSpecifiedCityInput(city: String, state: String, country: String, key: String, completion: @escaping (_ result: String) -> Void) {
        
        //converts the cities, state, and country into a URL safe format
        let newCity : String = city.stringByAddingPercentEncodingForRFC3986()!
        let newState : String = state.stringByAddingPercentEncodingForRFC3986()!
        let newCountry : String = country.stringByAddingPercentEncodingForRFC3986()!
        
        //semaphores are used for shared resources
        let semaphore = DispatchSemaphore (value: 0)
        
        let stringURL = "http://api.airvisual.com/v2/city?city=\(newCity)&state=\(newState)&country=\(newCountry)&key=\(key)"
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
    
    
    //PUBLIC GETTER METHODS
    public func getCity() -> String {
        return self.city
    }

    public func getState() -> String {
        return self.state
    }

    public func getCountry() -> String {
        return self.country
    }

    public func getCoordinates() -> [Double] {
        return self.coordinates
    }

    public func getAQI() -> Int {
        //resetAQI()
        return self.aqi
    }

    //PUBLIC SETTER METHODS
    //sets the new city
    public func setCity(city : String) -> Void {
        self.city = city
    }
    
    public func setState(state : String) -> Void {
        self.state = state
    }
    
    public func setCountry(country : String) -> Void {
        self.country = country
    }
    
    public func setCoordinates(coordinates : [Double]) -> Void {
        self.coordinates = coordinates
    }
    
    //PUBLIC Method for manually resetting AQI.
    //Not necessary to call if calling getAQI()
    public func resetAQI() -> Void {
        fetchData()
    }
}
