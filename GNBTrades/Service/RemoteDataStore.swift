//
//  RemoteDataStore.swift
//  GNBTrades
//
//  Created by Tomás Fernández Velazco on 04/06/2021.
//

import Foundation
import Moya

protocol APIServiceProtocol {
    func getRates(completion: @escaping ([Rate]?, Error?) -> Void)
    func getTransactions(completion: @escaping ([Transaction]?,  Error?) -> Void)
}

class RemoteDataStore: APIServiceProtocol {
    
    let baseProvider = MoyaProvider<BaseService>()
    
    func getRates(completion: @escaping ([Rate]?, Error?) -> Void) {
        
        baseProvider.request(.getRates) { result in
            switch result {
            case let .success(response):
                            
                do {
                     let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .useDefaultKeys
                    let rates = try decoder.decode([Rate].self, from: response.data)
                    completion(rates, nil)
                    
                } catch let error {
                    // Status code error or Mapping Error
                    print(error)
                    completion(nil, error)
                }
     
            case let .failure(error):
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
    
    func getTransactions(completion: @escaping ([Transaction]?, Error?) -> Void) {
        
        baseProvider.request(.getTransactions) { result in
            switch result {
            case let .success(response):
                            
                do {
                     let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .useDefaultKeys
                    let transactions = try decoder.decode([Transaction].self, from: response.data)
                    completion(transactions, nil)
                    
                } catch let error {
                    // Status code error or Mapping Error
                    print(error)
                    completion(nil, error)
                }
     
            case let .failure(error):
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
}
