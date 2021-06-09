//
//  ConversorHelper.swift
//  GNBTrades
//
//  Created by Tomás Fernández Velazco on 09/06/2021.


import Foundation

class ConversorHelper {
    
    private let rates: [Rate]
    
    init(rates: [Rate]) {
        self.rates = rates
    }
    
    func convert(_ amount: NSDecimalNumber, from: String, to: String) -> NSDecimalNumber? {

        if from == to {
            return amount.roundHalfToEvenBankingRounding()
        }
        
        if let directRate = getDirectRate(from: from, to: to) {
            return amount.multiplying(by: directRate).roundHalfToEvenBankingRounding()
        } else if let indirectRate = getIndirectRate(from: from, to: to) {
            return amount.multiplying(by: indirectRate).roundHalfToEvenBankingRounding()
        } else {
            return nil
        }
    }
    
    private func getDirectRate(from originCurrency: String, to destinationCurrenty: String) -> NSDecimalNumber? {
        
        guard let rateObj = (rates.first { $0.from == originCurrency && $0.to == destinationCurrenty }) else { return nil }
        
        let rate = rateObj.rate
        let rateD = NSDecimalNumber(string: rate)

        return rateD
    }
    
    private func getIndirectRate(from originCurrency: String, to destinationCurrenty: String) -> NSDecimalNumber? {
        
        guard let firstRateObj = (rates.first { $0.from == originCurrency }) else { return nil }
        
        guard let secondRateObj = (rates.first { $0.from == firstRateObj.to && $0.to == destinationCurrenty }) else { return nil }
        
        let firstRate = firstRateObj.rate
        let secondRate = secondRateObj.rate
        
        let firstR = NSDecimalNumber(string: firstRate)
        let secondR = NSDecimalNumber(string: secondRate)

        let finalRate = firstR.multiplying(by: secondR)
        return finalRate
    }
}
