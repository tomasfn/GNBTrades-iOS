//
//  ProductsVC+CollectionView.swift
//  GNBTrades
//
//  Created by Tomás Fernández Velazco on 05/06/2021.
//

import UIKit

extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self        
        let nib = UINib(nibName: ProductCollectionViewCell.nameOfClass, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: ProductCollectionViewCell.nameOfClass)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getProductsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: Float = 16.0
        let numberOfItemsPerRow:CGFloat = 2
        let spacingBetweenCells:CGFloat = 4
            
        let totalSpacing = (2 * CGFloat(spacing)) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
            
        if let collection = self.collectionView{
            let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
            return CGSize(width: width, height: width)
            
        }else{
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.nameOfClass, for: indexPath) as! ProductCollectionViewCell
        presenter.configure(cell: cell, for: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.showDetails(index: indexPath.row)
    }
}
