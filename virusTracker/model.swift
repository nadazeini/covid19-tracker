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
    var Cases: Int
    var Status: String
    var Date: String
}
