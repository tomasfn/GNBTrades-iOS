//
//  BaseService.swift
//  GNBTrades
//
//  Created by Tomás Fernández Velazco on 05/06/2021.
//

import Foundation
import Moya

enum BaseService {
    case getRates
    case getTransactions
}

extension BaseService: TargetType {
    
    var baseURL: URL {
        return URL(string: "http://quiet-stone-2094.herokuapp.com")!
    }
    
    var path: String {
        switch self {
        case .getRates:
            return "/rates"
        case .getTransactions:
            return "/transactions"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return [
            "Accept" : "application/json",
            "Content-Type" : "application/json"
        ]
    }
}
