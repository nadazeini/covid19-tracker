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
    var Date: String
}
func countryList() -> [String] {
    var countries: [String] = []
    for code in NSLocale.isoCountryCodes  {
        let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
        let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
        countries.append(name)
    }
    countries.sort()
    return countries
}
func getStat(country: String) -> Stat {
        let url = URL(string: "https://api.covid19api.com/dayone/country/\(country)")
    var countryStat = Stat(Country: country, Confirmed: 0, Active: 0, Recovered: 0, Deaths: 0, Date: "N/A")
//        print(AppDelegate.stats.count)
        guard let requestUrl = url else { return countryStat; }
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
                        print("Response data string:\n \(dataString)")
                    do{
                        let stat = try decoder.decode([Stat].self, from: dataString.data(using: .utf8)!) //array
                            print(stat)
                        if stat.count == 0 {
                            return
                        }
                        print(stat[stat.count-1])
                        countryStat.Active = stat[stat.count-1].Active
                        countryStat.Recovered = stat[stat.count-1].Recovered
                        countryStat.Confirmed = stat[stat.count-1].Confirmed
                        countryStat.Deaths = stat[stat.count-1].Deaths
                        
                        print(countryStat.Deaths)
//                        AppDelegate.stats.append(stat[stat.count-1])
                        //added each stat to stats array of stat objects
                        
                    } catch {
                        print(error)
                    }
                    
                }
            }
        task.resume()
        return countryStat
    }
