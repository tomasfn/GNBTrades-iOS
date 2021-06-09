//
//  TransactionTableViewCell.swift
//  GNBTrades
//
//  Created by Tomás Fernández Velazco on 05/06/2021.
//

import UIKit

class TransactionTableViewCell: UITableViewCell, TransactionCellView {
   
    @IBOutlet weak var transactionInfoLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func displayTransaction(transaction: Transaction) {
        transactionInfoLabel.text = "\(transaction.amount) \(transaction.currency)"
    }
}
