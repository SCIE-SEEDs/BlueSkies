//
//  ViewController.swift
//  backend creation
//
//  Created by Serina Khanna on 8/4/20.
//  Copyright © 2020 Serina Khanna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       /*fetchSmogSpecifiedCityinput(input: "Los Angeles") {
            (result: String) in
                print("got back: \(result)")
        } */
        fetcherData(city: "Los Angeles", state: "California", country: "USA")
    }

    @IBAction func showMessage(sender: UIButton) {
        let alertController = UIAlertController(title: "Welcome to My First App", message: "Hello World", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
}

