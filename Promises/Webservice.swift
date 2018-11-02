//
//  Webservice.swift
//  Promises
//
//  Created by federico mazzini on 02/11/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

class Webservice {
    
    static let charactersURLString: String = "http://www.mocky.io/v2/5bdca56b330000112581366a"
    
    // Classic fetch.
    static func fetchCharacters(completion: @escaping ([Character]?) -> ()) {
        Alamofire.request(charactersURLString).responseData(completionHandler: { response in
            
            if let data = response.data
            {
                do {
                    let decoder = JSONDecoder()
                    let characters: [Character] = try decoder.decode([Character].self, from: data)
                    
                    completion(characters)
                }
                catch {
                    completion(nil)
                }
            }
            else {
                completion(nil)
            }
        })
    }
    
    // Fetch using promises.
    static func fetchCharacters() -> Promise<[Character]> {
        let q = DispatchQueue.global()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        return firstly {
            Alamofire.request(charactersURLString, method: .get).responseData()
            }.map(on: q) { data, rsp in
                let decoder = JSONDecoder()
                let characters: [Character] = try decoder.decode([Character].self, from: data)
                return characters
            }.ensure {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
    static func attempt<T>(maximumRetryCount: Int = 3, delayBeforeRetry: DispatchTimeInterval = .seconds(2), _ body: @escaping () -> Promise<T>) -> Promise<T> {
        var attempts = 0
        func attempt() -> Promise<T> {
            attempts += 1
            return body().recover { error -> Promise<T> in
                guard attempts < maximumRetryCount else { throw error }
                return after(delayBeforeRetry).then(on: nil, attempt)
            }
        }
        return attempt()
    }
    
}
