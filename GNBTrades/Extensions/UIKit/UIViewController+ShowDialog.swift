//
//  UIViewController+ShowDialog.swift
//  GNBTrades
//
//  Created by Tomás Fernández Velazco on 09/06/2021.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlertDialog(title: String?, message: String?) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle:.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
}
