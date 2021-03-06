//
//  TransactionsVC+TableView.swift
//  GNBTrades
//
//  Created by Tomás Fernández Velazco on 06/06/2021.
//

import UIKit

extension TransactionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setUpTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: TransactionTableViewCell.nameOfClass, bundle: nil), forCellReuseIdentifier: TransactionTableViewCell.nameOfClass)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getTransactionsCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.nameOfClass, for: indexPath) as! TransactionTableViewCell
        presenter.configure(cell: cell, for: indexPath.row)
        return cell
    }
        
    func tableView(_ tableView: UITableView,
                   heightForFooterInSection section: Int) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView,
                   viewForFooterInSection section: Int) -> UIView? {
        //Created a footer to display sum of all Transactions
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 70))
        
        footerView.backgroundColor = .lightGray
        
        let totalLbl = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 70))
        totalLbl.font = UIFont.systemFont(ofSize: 20)
        
        let desiredCurrency = Currency.EUR
        totalLbl.text = "Total sum in \(desiredCurrency): \(presenter.totalAmountSumOfTransactions(in: desiredCurrency))"
        totalLbl.center.x = footerView.center.x
        totalLbl.textAlignment = .center
        footerView.addSubview(totalLbl)
        
        return footerView
    }
}
