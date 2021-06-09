//
//  TransactionsVC+PresenterDelegate.swift
//  GNBTrades
//
//  Created by Tomás Fernández Velazco on 06/06/2021.
//

import Foundation

extension TransactionsViewController: TransactionsView {

    func reloadTableDetails() {
        tableView.reloadData()
    }
    
    func showError(error: String) {
        print(error)
    }
}
