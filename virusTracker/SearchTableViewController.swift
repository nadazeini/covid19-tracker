//
//  SearchTableViewController.swift
//  virusTracker
//
//  Created by Nada Zeini on 5/25/20.
//  Copyright © 2020 Nada Zeini. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController,UISearchResultsUpdating {
   
    //something great
    
    @IBOutlet weak var searchBar: UISearchBar!
    var data = countryList()
    var filteredData =  [String]()
    var resultSearchController = UISearchController()
    static var selectedCountry: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
//        filteredData = data
        resultSearchController = ({
          let controller = UISearchController(searchResultsController: nil)
                controller.searchResultsUpdater = self
                controller.dimsBackgroundDuringPresentation = false
                controller.searchBar.sizeToFit()
                tableView.tableHeaderView = controller.searchBar
                return controller
            })()
        
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(resultSearchController.isActive){
            return filteredData.count
        }
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(resultSearchController.isActive){
            SearchTableViewController.selectedCountry = filteredData[indexPath.row].replacingOccurrences(of: " ", with: "-") as! String
            print("selected")
            print(SearchTableViewController.selectedCountry)
            
        }
        else{
        SearchTableViewController.selectedCountry = data[indexPath.row].replacingOccurrences(of: " ", with: "-") as! String
        print(SearchTableViewController.selectedCountry)
        }
        
        // Clear the Search bar text
        resultSearchController.isActive = false
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CountryCell
        if(resultSearchController.isActive){
                cell.countryName.text = filteredData[indexPath.row]
        }
        else{
            cell.countryName.text = data[indexPath.row]
        }
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let cell = sender as! CountryCell
            let indexPath = tableView.indexPath(for: cell)
        if(resultSearchController.isActive){
            let country = filteredData[indexPath!.row]
            let detailsVC = segue.destination as! CountryStatsViewController
            detailsVC.country = country
        }
        else{
            
            let country = data[indexPath!.row]
            let detailsVC = segue.destination as! CountryStatsViewController
            detailsVC.country = country
        }

            
        }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
        // If dataItem matches the searchText, return true to include it
        return dataString.range(of: searchText, options: .caseInsensitive) != nil
    })

    tableView.reloadData()
    }
    func updateSearchResults(for searchController: UISearchController) {
        
             filteredData.removeAll(keepingCapacity: true)
        
        let searchPredicate = NSPredicate(format: "SELF BEGINSWITH[c] %@", searchController.searchBar.text!)
          let array = (data as NSArray).filtered(using: searchPredicate)
          filteredData = array as! [String]
        self.tableView.reloadData()
    }
}
