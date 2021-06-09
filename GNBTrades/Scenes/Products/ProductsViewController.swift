//
//  ProductsViewController.swift
//  GNBTrades
//
//  Created by Tomás Fernández Velazco on 04/06/2021.
//

import UIKit
import Foundation

class ProductsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var presenter: ProductsVCPresenter!
                    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Products"
        setUpCollectionView()
        loadData()
    }
    
    func loadData() {
        presenter = ProductsVCPresenter(view: self)
        presenter.viewDidLoad()
    }
}


