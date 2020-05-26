//
//  model.swift
//  virusTracker
//
//  Created by Nada Zeini on 5/22/20.
//  Copyright © 2020 Nada Zeini. All rights reserved.
//

import Foundation

struct Stat: Codable {
    var Country: String
    var Confirmed: Int
    var Active: Int
    var Recovered: Int
    var Deaths: Int
}
func getStat(country: String) -> Void {
    let url = URL(string: "https://api.covid19api.com/live/country/\(country)")
    print(url)
    guard let requestUrl = url else { return; }
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
//            if let response = response as? HTTPURLResponse {
//                print("Response HTTP Status code: \(response.statusCode)")
//            }
            let decoder = JSONDecoder()
            // Convert HTTP Response Data to a simple String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
    //                print("Response data string:\n \(dataString)")
                do{
                    let stat = try decoder.decode([Stat].self, from: dataString.data(using: .utf8)!) //array
    //                    print(stat)
                    if stat.count == 0 {
                        return
                    }
                    print(stat[stat.count-1])
                    
                } catch {
                    print(error)
                }
            }
        }
    task.resume()
}
func countryList() -> [String] {
    var countries: [String] = []
    for code in NSLocale.isoCountryCodes  {
        let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
        let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
        let country = name.replacingOccurrences(of: " ", with: "-")
        countries.append(country)
    }
    countries.sort()
    return countries
}
