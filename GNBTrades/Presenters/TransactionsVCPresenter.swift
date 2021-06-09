//
//  SelectedProductVCPresenter.swift
//  GNBTrades
//
//  Created by Tomás Fernández Velazco on 06/06/2021.
//

import Foundation

protocol TransactionsView: class {
    func reloadTransactionsDetails()
    func showError(error: String)
}

protocol TransactionCellView {
    func displayTransaction(transaction: Transaction)
}

class TransactionsVCPresenter {
    
    private weak var view: TransactionsView?
    
    private var transactions = [Transaction]()
    private var rates = [Rate]()
                
    init(transactions: [Transaction], rates: [Rate]) {
        self.transactions = transactions
        self.rates = rates
    }

    func setView(_ view: TransactionsView) {
        self.view = view
    }
        
    func totalAmountSumOfTransactions(in currency: Currency) -> Double {
        
        var totalSum = Double()
        var currencyConversion: Currency!
        
        for transaction in transactions {
            currencyConversion = Currency(rawValue: transaction.currency)
            
            switch currencyConversion {
            case currency:
                //Si la currency actual de la transaccion es la establecida, la sumo
                totalSum = totalSum + Double(transaction.amount)!
            default:
                //Sino, creo conversiones previas para obtener el valor en esa moneda
                let rateToUse = rates.filter {$0.from == currencyConversion.rawValue }
                
                for rate in rateToUse {
                    //Evaluo si es conversion directa, y sumo
                    let into = rate.to
                    if into == currency.rawValue {
                        let converted1 = (Double(rate.rate)! * Double(transaction.amount)!)
                        let decimal = NSDecimalNumber(value: converted1)
                        totalSum = Double(truncating: decimal.roundHalfToEvenBankingRounding()) + totalSum
                    } else {
                        //Sino es conversion directa, aplicamos mas conversiones
                        let ratesToUse2 = rates.filter { $0.from == transaction.currency }
                        
                        for rat in ratesToUse2 {
                            let into2 = rat.to
                            if into2 == currency.rawValue {
                                let converted2 = (Double(rat.rate)! * Double(transaction.amount)!)
                                let decimal = NSDecimalNumber(value: converted2)
                                totalSum = Double(truncating: decimal.roundHalfToEvenBankingRounding()) + totalSum
                            }
                        }
                    }
                }
            }
        }
        
        return totalSum.rounded()
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
