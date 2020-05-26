//
//  AppDelegate.swift
//  virusTracker
//
//  Created by Nada Zeini on 5/22/20.
//  Copyright © 2020 Nada Zeini. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        var countries: [String] = []

               for code in NSLocale.isoCountryCodes  {
                   let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
                   let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
                   let country = name.replacingOccurrences(of: " ", with: "-")
                   countries.append(country)
               }
               for country in countries{
                   getStat(country: country)
               }
        return true
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

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

