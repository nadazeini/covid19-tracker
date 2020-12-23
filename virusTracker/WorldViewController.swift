//
//  WorldViewController.swift
//  virusTracker
//
//  Created by Nada Zeini on 5/26/20.
//  Copyright © 2020 Nada Zeini. All rights reserved.
//

import UIKit

class WorldViewController: UIViewController {
    
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var greyView: UIView!
    @IBOutlet weak var confirmedWorld: UILabel!
    @IBOutlet weak var recoveredWorld: UILabel!
    @IBOutlet weak var deathsWorld: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        redView.layer.cornerRadius = 10
        greenView.layer.cornerRadius = 10
        greyView.layer.cornerRadius = 10
        
        let url = URL(string: "https://api.covid19api.com/world/total")
        var worldStat = WorldStat(TotalConfirmed: 0, TotalRecovered: 0, TotalDeaths: 0)
        guard let requestUrl = url else {
            confirmedWorld.text = "N/A"
            recoveredWorld.text = "N/A"
            deathsWorld.text = "N/A"
            return  }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error took place \(error)")
                return
            }
            let decoder = JSONDecoder()
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
                do{
                    let stat = try decoder.decode(WorldStat.self, from: dataString.data(using: .utf8)!)
                    worldStat.TotalRecovered = stat.TotalRecovered
                    worldStat.TotalConfirmed = stat.TotalConfirmed
                    worldStat.TotalDeaths = stat.TotalDeaths
                    DispatchQueue.main.async {
                        self.confirmedWorld.text = String(format: "%d", locale: Locale.current, worldStat.TotalConfirmed)
                        self.recoveredWorld.text = String(format: "%d", locale: Locale.current,worldStat.TotalRecovered)
                        self.deathsWorld.text = String(format: "%d", locale: Locale.current,worldStat.TotalDeaths)
                    }
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
}
