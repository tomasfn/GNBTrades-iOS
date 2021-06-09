//
//  ProductsVC+PresenterDelegate.swift
//  GNBTrades
//
//  Created by Tomás Fernández Velazco on 05/06/2021.
//

import Foundation

extension ProductsViewController: ProductsView {
    
    func showIndicator() {
        indicator.startAnimating()
        indicator.isHidden = false
    }
    
    func hideIndicator() {
        indicator.stopAnimating()
        indicator.isHidden = true
    }
    
    func fetchingDataSuccess() {
        collectionView.reloadData()
    }
    
    func showError(message: String) {
        showAlertDialog(title: "Error", message: message)
    }
    
    func showTransactions(nextPresenter: TransactionsVCPresenter) {
        let vc = TransactionsViewController.`init`(with: nextPresenter)
        navigationController?.pushViewController(vc, animated: true)
    }
}
