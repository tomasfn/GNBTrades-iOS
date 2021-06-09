//
//  SelectedProductViewController.swift
//  GNBTrades
//
//  Created by Tomás Fernández Velazco on 04/06/2021.
//

import Foundation
import UIKit


class TransactionsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: TransactionsVCPresenter!
    
    static func `init`(with presenter: TransactionsVCPresenter) -> TransactionsViewController {
        let vc = NavigationHelper.transactionsViewController()
        vc.presenter = presenter
        return vc
    }
    
    override func viewDidLoad() {
        title = "Product SKU: \(presenter.getCurrentProductIdInContext()) Transactions"
        presenter.setView(self)        
        setUpTable()
    }
}
