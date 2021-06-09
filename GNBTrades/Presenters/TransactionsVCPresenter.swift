//
//  SelectedProductVCPresenter.swift
//  GNBTrades
//
//  Created by Tomás Fernández Velazco on 06/06/2021.
//

import Foundation

protocol TransactionsView: class {
    func reloadTableDetails()
    func showError(message: String)
}

protocol TransactionCellView {
    func displayTransaction(transaction: Transaction)
}

class TransactionsVCPresenter {
    
    private weak var view: TransactionsView?
    
    private var transactions: [Transaction] = []
    private var rates: [Rate] = []
                
    init(transactions: [Transaction], rates: [Rate]) {
        self.transactions = transactions
        self.rates = rates
    }

    func setView(_ view: TransactionsView) {
        self.view = view
    }
        
    func totalAmountSumOfTransactions(in desiredCurrency: Currency) -> NSDecimalNumber {
        
        var total = NSDecimalNumber.zero
        let conversorHelper = ConversorHelper(rates: rates)
        
        transactions.forEach { (transaction) in
            if let convertedNumber = conversorHelper.convert(NSDecimalNumber(string: transaction.amount), from: transaction.currency, to: desiredCurrency.rawValue) {
                total = total.adding(convertedNumber)
            }
        }
        
        return total.makeRoundingNumber(with: 2)
    }
    
    func getCurrentProductIdInContext() -> String {
        let skuNumbers = transactions.map { $0.sku }
        let uniqueSkus = Set(skuNumbers)
        return uniqueSkus.joined()
    }
    
    func getTransactionsCount() -> Int {
        return transactions.count
    }
    
    func configure(cell: TransactionCellView,for index: Int) {
        let transaction = transactions[index]
        cell.displayTransaction(transaction: transaction)
    }
}
