//
//  Product.swift
//  GNBTrades
//
//  Created by Tomás Fernández Velazco on 04/06/2021.
//

import Foundation

struct Product: Codable {
    let sku: String
    
    init(sku: String) {
        self.sku = sku
    }
}
