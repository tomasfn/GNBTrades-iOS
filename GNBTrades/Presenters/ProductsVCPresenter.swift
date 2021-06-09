//
//  ProductsVCPresenter.swift
//  GNBTrades
//
//  Created by Tomás Fernández Velazco on 05/06/2021.
//

import Foundation

protocol ProductsView: class {
    func showIndicator()
    func hideIndicator()
    func fetchingDataSuccess()
    func showError(error: String)
    func showTransactions(nextPresenter: TransactionsVCPresenter)
}

protocol ProductCellView {
    func displaySku(sku: String)
}

class ProductsVCPresenter {
    
    private weak var view: ProductsView?
    private let dataStore = RemoteDataStore()
    
    private var transactions = [Transaction]()
    private var products = [Product]()
    private var rates = [Rate]()
    
    private var list = [Rate]()
    private var toEUR = [String]()
        
    init(view: ProductsView) {
        self.view = view
    }
    
    func viewDidLoad() {
        getTransactions()
        getRates()
    }
    
    func getTransactions() {
        
        view?.showIndicator()
        dataStore.getTransactions { [weak self] (transactions, error) in
            guard let self = self else { return }
            self.view?.hideIndicator()
            
            if let error = error {
                self.view?.showError(error: error.localizedDescription)
            } else {
                guard let transactions = transactions else { return }
                self.transactions = transactions
                self.getProducstFrom(transactions: self.transactions)
                self.view?.fetchingDataSuccess()
            }
        }
    }
    
    func getRates() {
        
        dataStore.getRates { [weak self] (rates, error) in
            guard let self = self else { return }
            if let error = error {
                self.view?.showError(error: error.localizedDescription)
            } else {
                guard let rates = rates else { return }
                self.rates = rates
                self.ratesManage()
            }
        }
    }
    
    func getProducstFrom(transactions:[Transaction]) {
        
        var products = [Product]()
                
        let skuNumbers = transactions.map { $0.sku }
        let uniqueSkus = Array(Set(skuNumbers))
                
        for sku in uniqueSkus {
            let product = Product(sku: sku)
            products.append(product)
        }
        
        self.products = products
    }
    
    func showDetails(index: Int) {
        let product = products[index]
        let productTransactions = transactions.filter({ $0.sku == product.sku })
        let nextPresenter = TransactionsVCPresenter(transactions: productTransactions, rates: self.rates)
        view?.showTransactions(nextPresenter: nextPresenter)
    }
            
    func getProductsCount() -> Int {
        return products.count
    }
    
    func configure(cell: ProductCellView,for index: Int) {
        let product = products[index]
        cell.displaySku(sku: product.sku)
    }
    
    
    func ratesManage() {
    
        var myRates = [Rate]()

        for rate in rates {
                        
            let someRates = rates.filter({ $0.from == rate.from && $0.from != Currency.EUR.rawValue || $0.to == rate.to && $0.to != Currency.EUR.rawValue})
            
            for item in someRates {
                let value = (Double(rate.rate)! / Double(item.rate)!).roundedByTwoDecimals()
                let valueStr = String(value)
                            
                if (item.from == rate.from) && item.to == "EUR" && rate != item {
                    let aRate = Rate(from: rate.to, to: item.to, rate:valueStr)
                    myRates.append(aRate)
                } else if item.to == rate.to && rate.to == "EUR" && rate != item {
                    let aRate = Rate(from: item.from, to: rate.from, rate:valueStr)
                    myRates.append(aRate)
                }
            }
            
            let uniqueRates = Array(Set(myRates))
            
            let filt2 = uniqueRates.filter({ $0.from == rate.from || $0.to == rate.to})
            
            for fil in filt2 {
                let value = (Double(rate.rate)! / Double(fil.rate)!).roundedByTwoDecimals()
                let valueStr = String(value)
                
                if rate.to != fil.to {
                    let aRate = Rate(from: rate.to, to: fil.to, rate:valueStr)
                    myRates.append(aRate)
                }
            }
        }
    }
}

