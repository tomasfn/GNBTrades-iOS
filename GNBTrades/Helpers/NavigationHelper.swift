//
//  NavigationHelper.swift
//  GNBTrades
//
//  Created by Tomás Fernández Velazco on 09/06/2021.
//

import Foundation
import UIKit

class NavigationHelper {
    
    static let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)

    class func productsViewController() -> ProductsViewController {
        let productsVc = mainStoryboard.instantiateViewController(withIdentifier: ProductsViewController.nameOfClass) as! ProductsViewController
        return productsVc
    }
    
    class func transactionsViewController() -> TransactionsViewController {
        let transactionsVc = mainStoryboard.instantiateViewController(withIdentifier: TransactionsViewController.nameOfClass) as! TransactionsViewController
        return transactionsVc
    }
}
