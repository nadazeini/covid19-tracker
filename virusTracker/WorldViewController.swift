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
    @IBOutlet weak var orangeView: UIView!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var greyView: UIView!
    @IBOutlet weak var confirmedWorld: UILabel!
    @IBOutlet weak var activeWorld: UILabel!
    @IBOutlet weak var recoveredWorld: UILabel!
    @IBOutlet weak var deathsWorld: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        redView.layer.cornerRadius = 10
        orangeView.layer.cornerRadius = 10
        greenView.layer.cornerRadius = 10
        greyView.layer.cornerRadius = 10
    }
}
