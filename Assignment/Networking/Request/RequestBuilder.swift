//
//  RequestBuilder.swift
//  EdWithProject5
//
//  Created by 고상범 on 2018. 8. 29..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit



class RequestBuilder {
    
    let session = URLSession.shared
    
    public typealias ReqeustCompletionBlock = (Result<Data>,URLResponse?) -> Void
    
    func makeRequest(form: MovieAPI) -> URLRequest {
        guard let url: URL = form.urlComponents.url else {
                        
            fatalError("failed to make URL")
                        
                }
        let request = URLRequest(url: url)
        print(url)
        return request
    }
    
    func request(form: MovieAPI, _ completion: @escaping ReqeustCompletionBlock) {
        
        let request = makeRequest(form: form)
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                
                if let error = error {
                    print ("error: \(error)")
                    completion(.failure(error), response)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    return
                }
                
                guard let localResponse = response as? HTTPURLResponse,
                    (200...299).contains(localResponse.statusCode) else {
                        print ("server error")
                        let serverError = NSError(domain: "serverError", code: 0, userInfo: nil)
                        completion(.failure(serverError), response)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        return
                }
                
                if let mimeType = localResponse.mimeType,
                    mimeType == "application/json",
                    let data = data,
                    let dataString = String(data: data, encoding: .utf8) {
                    completion(.success(data), localResponse)
                    OperationQueue.main.addOperation {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    }
                    print(dataString)
                } else {
                    let serverError = NSError(domain: "serverIsNotWorkingError", code: 0, userInfo: nil)
                    completion(.failure(serverError), response)
                    OperationQueue.main.addOperation {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    }
                    return
                }
            })
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            task.resume()
        }


}









