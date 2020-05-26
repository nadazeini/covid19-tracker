//
//  SearchTableViewController.swift
//  virusTracker
//
//  Created by Nada Zeini on 5/25/20.
//  Copyright © 2020 Nada Zeini. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return countryList().count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CountryCell
        
        
        cell.countryName.text = countryList()[indexPath.row]
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let cell = sender as! CountryCell
            let indexPath = tableView.indexPath(for: cell)
            let country = countryList()[indexPath!.row]

            let detailsVC = segue.destination as! CountryStatsViewController
            detailsVC.country = country
        }
}
