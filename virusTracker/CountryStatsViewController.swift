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
    @IBOutlet weak var confirmedCases: UILabel!
    @IBOutlet weak var activeCases: UILabel!
    @IBOutlet weak var recoveredCases: UILabel!
    @IBOutlet weak var deathsCases: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = country
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.red]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        redView.layer.cornerRadius = 10
        orangeView.layer.cornerRadius = 10
        greenView.layer.cornerRadius = 10
        blackView.layer.cornerRadius = 10
        
    }
}
