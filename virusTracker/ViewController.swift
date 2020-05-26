//
//  ViewController.swift
//  virusTracker
//
//  Created by Nada Zeini on 5/22/20.
//  Copyright © 2020 Nada Zeini. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://api.covid19api.com/country/south-africa/status/deaths/live")
        guard let requestUrl = url else { fatalError() }
        // Create URL Request
        var request = URLRequest(url: requestUrl)
        // Specify HTTP Method to use
        request.httpMethod = "GET"
        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            let decoder = JSONDecoder()
            // Convert HTTP Response Data to a simple String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
//                print("Response data string:\n \(dataString)")
                do{
                    let stat = try decoder.decode([Stat].self, from: dataString.data(using: .utf8)!) //array
//                    print(stat)
                    print(stat[stat.count-1])
                } catch {
                    print(error)
                }
            }

        }
        task.resume()
        
    }
}

