//
//  ProductCollectionViewCell.swift
//  GNBTrades
//
//  Created by Tomás Fernández Velazco on 05/06/2021.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell, ProductCellView {
    
    @IBOutlet weak var skuNumber: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func displaySku(sku: String) {
        skuNumber.text = "SKU: \(sku)"
    }
}
