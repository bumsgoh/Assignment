//
//  APIService.swift
//  Assignment
//
//  Created by 고상범 on 2018. 12. 6..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

protocol APIService {
    
    var session: URLSession { get }
    
    func fetch<T: Decodable>(with request: URLRequest, decodeType: T.Type, completion: @escaping (Result<T>, URLResponse?) -> Void)
}

extension APIService {
    
   func fetch<T: Decodable>(with request: URLRequest, decodeType: T.Type, completion: @escaping (Result<T>, URLResponse?) -> Void) {
    DispatchQueue.main.async {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(.failure(APIError.requestFailed), response)
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                return
            }
            
            guard let localResponse = response as? HTTPURLResponse,
                (200...299).contains(localResponse.statusCode) else {
                    completion(.failure(APIError.responseUnsuccessful), response)
                    DispatchQueue.main.async {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    }
                    return
            }
            
            if let mimeType = localResponse.mimeType,
                mimeType == "application/json",
                let data = data {
                    do {
                        let apiResponse = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(apiResponse), response)
                        DispatchQueue.main.async {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        }
                    } catch(_ ) {
                        completion(.failure(APIError.jsonParsingFailure), nil)
                        DispatchQueue.main.async {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        }
                    }
            } else {
                completion(.failure(APIError.invalidData), response)
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                return
            }
        }
    
    task.resume()
    }
    
    
    
}
