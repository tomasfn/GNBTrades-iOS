//
//  Commons.swift
//  GNBTrades
//
//  Created by Tomás Fernández Velazco on 04/06/2021.
//

import Foundation
import UIKit

extension NSObject {
    public class var nameOfClass: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}

extension NSDecimalNumber {
    func roundHalfToEvenBankingRounding() -> NSDecimalNumber {
        let handler = NSDecimalNumberHandler(roundingMode: NSDecimalNumber.RoundingMode.bankers, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        let rounded = self.rounding(accordingToBehavior: handler)
        
        return rounded
    }
}

extension Double {
    func roundedByTwoDecimals() -> Double {
        let divisor = pow(10.0, Double(2))
        return (self * divisor).rounded() / divisor
    }
}
