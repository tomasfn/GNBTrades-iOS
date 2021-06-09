//
//  Commons.swift
//  GNBTrades
//
//  Created by Tomás Fernández Velazco on 04/06/2021.
//

import Foundation

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

    func makeRoundingNumber(with scale: Int16) -> NSDecimalNumber {
        let numberHandler = NSDecimalNumberHandler(roundingMode: .plain, scale: scale, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        return self.rounding(accordingToBehavior: numberHandler)
    }
}

