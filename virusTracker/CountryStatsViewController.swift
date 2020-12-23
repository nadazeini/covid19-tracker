//
//  CountryStatsViewController.swift
//  virusTracker
//
//  Created by Nada Zeini on 5/26/20.
//  Copyright © 2020 Nada Zeini. All rights reserved.
//

import UIKit

class CountryStatsViewController: UIViewController {
    var country = ""
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var orangeView: UIView!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var blackView: UIView!
    
    @IBOutlet weak var deathsCases: UILabel!
    @IBOutlet weak var activeCases: UILabel!
    @IBOutlet weak var recoveredCases: UILabel!
    @IBOutlet weak var confirmedCases: UILabel!
    @IBOutlet weak var latestDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.red]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = country
        print("here \(SearchTableViewController.selectedCountry)")
        redView.layer.cornerRadius = 10
        orangeView.layer.cornerRadius = 10
        greenView.layer.cornerRadius = 10
        blackView.layer.cornerRadius = 10
        //why doesnt this work? make reusable!
        //        let countryStats: Stat = getStat(country: SearchTableViewController.selectedCountry)
        
        let url = URL(string: "https://api.covid19api.com/dayone/country/\(SearchTableViewController.selectedCountry)")
        var countryStat = Stat(Country: country, Confirmed: 0, Active: 0, Recovered: 0, Deaths: 0, Date: "N/A")
        //        print(AppDelegate.stats.count)
        guard let requestUrl = url else {
            confirmedCases.text = "N/A"
            recoveredCases.text = "N/A"
            deathsCases.text = "N/A"
            activeCases.text = "N/A"
            latestDate.text = "N/A"
            return  }
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
                    print(stat)
                    if stat.count == 0 {
                        return
                    }
                    countryStat.Active = stat[stat.count-1].Active
                    countryStat.Recovered = stat[stat.count-1].Recovered
                    countryStat.Confirmed = stat[stat.count-1].Confirmed
                    countryStat.Deaths = stat[stat.count-1].Deaths
                    //format date string
                    let dateStr = stat[stat.count-1].Date
                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = Locale(identifier: "en_US_POSTFIX")
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                    let date = dateFormatter.date(from: dateStr)!
                    dateFormatter.dateFormat = "MM - dd - yyyy"
                    let dateDisplayed = dateFormatter.string(from: date)
                    countryStat.Date = dateDisplayed
//                    self.navigationItem.title = countryStat.Country.replacingOccurrences(of: "-", with: " ")
                    DispatchQueue.main.async {
                        self.confirmedCases.text = String(format: "%d", locale: Locale.current, countryStat.Confirmed)
                        self.recoveredCases.text = String(format: "%d", locale: Locale.current,countryStat.Recovered)
                        self.deathsCases.text = String(format: "%d", locale: Locale.current,countryStat.Deaths)
                        self.activeCases.text = String(format: "%d", locale: Locale.current,countryStat.Active)
                        self.latestDate.text = String(countryStat.Date)
                    }
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
}
