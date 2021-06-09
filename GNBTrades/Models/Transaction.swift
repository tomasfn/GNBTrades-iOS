//
//  Transaction.swift
//  GNBTrades
//
//  Created by Tomás Fernández Velazco on 04/06/2021.
//

import Foundation

struct Transaction: Codable {
    let sku: String
    let amount: String
    let currency: String
}
