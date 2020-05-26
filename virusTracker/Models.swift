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
