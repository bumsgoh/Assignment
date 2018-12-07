//
//  APIService.swift
//  Assignment
//
//  Created by 고상범 on 2018. 12. 6..
//  Copyright © 2018년 고상범. All rights reserved.
//

import Foundation

protocol APIService {
    
    var session: URLSession { get }
    
  //  associatedtype T: Decodable
    
    func fetch<T: Decodable>(with request: URLRequest, decodeType: T.Type, completion: @escaping (Result<T>, URLResponse?) -> Void)
}

extension APIService {
    
    func fetch<T: Decodable>(with request: URLRequest, decodeType: T.Type, completion: @escaping (Result<T>, URLResponse?) -> Void) {

        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print ("error: \(error)")
                completion(.failure(error), response)
                return
            }
            
            guard let localResponse = response as? HTTPURLResponse,
                (200...299).contains(localResponse.statusCode) else {
                    print ("server error")
                    let serverError = NSError(domain: "serverError", code: 0, userInfo: nil)
                    completion(.failure(serverError), response)
                    return
            }
            
            if let mimeType = localResponse.mimeType,
                mimeType == "application/json",
                let data = data {
                    do {
                        let apiResponse = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(apiResponse), response)
                    } catch(let err) {
                        print(err.localizedDescription)
                        completion(.failure(err), nil)
                    }
            } else {
                let serverError = NSError(domain: "serverIsNotWorkingError", code: 0, userInfo: nil)
                completion(.failure(serverError), response)
                return
            }
        }
    
    task.resume()
    }
    
    
    
}
