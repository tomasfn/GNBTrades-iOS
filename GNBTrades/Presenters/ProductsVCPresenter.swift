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
    func showError(message: String)
    func showTransactions(nextPresenter: TransactionsVCPresenter)
}

protocol ProductCellView {
    func displayProductSku(sku: String)
}

class ProductsVCPresenter {
    
    private weak var view: ProductsView?
    private let dataStore = RemoteDataStore()
    
    private var transactions: [Transaction] = []
    private var rates: [Rate] = []
    private var products: [Product] = []
    
    init(view: ProductsView) {
        self.view = view
    }
    
    func viewDidLoad() {
        fectTransactions()
        fetchRates()
    }
    
    func fectTransactions() {
        
        view?.showIndicator()
        dataStore.getTransactions { [weak self] (transactions, error) in
            guard let self = self else { return }
            self.view?.hideIndicator()
            if let error = error {
                self.view?.showError(message: error.localizedDescription)
            } else {
                guard let transactions = transactions else { return }
                self.transactions = transactions
                self.fetchProducstFrom(transactions: self.transactions)
                self.view?.fetchingDataSuccess()
            }
        }
    }
    
    func fetchRates() {
        
        dataStore.getRates { [weak self] (rates, error) in
            guard let self = self else { return }
            if let error = error {
                self.view?.showError(message: error.localizedDescription)
            } else {
                guard let rates = rates else { return }
                self.rates = rates
            }
        }
    }
    
    func fetchProducstFrom(transactions:[Transaction]) {
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
        cell.displayProductSku(sku: product.sku)
    }
}

