//
//  Rate.swift
//  GNBTrades
//
//  Created by Tomás Fernández Velazco on 04/06/2021.
//

import Foundation

struct Rate: Codable, Equatable, Hashable {
    let from: String
    let to: String
    let rate: String
    
    init(from: String, to: String, rate: String) {
        self.from = from
        self.to = to
        self.rate = rate
    }
    
    static func ==(lhs: Rate, rhs: Rate) -> Bool {
        return lhs.from == rhs.from && lhs.to == rhs.to && lhs.rate == rhs.rate
    }
}
