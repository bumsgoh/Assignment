//
//  NetworkManager.swift
//  Assignment
//
//  Created by 고상범 on 2018. 12. 7..
//  Copyright © 2018년 고상범. All rights reserved.
//


import UIKit

class NetworkManager: APIService {
   
    let session: URLSession
    
    private init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    private convenience init() {
        self.init(configuration: .default)
        self.session.configuration.timeoutIntervalForRequest = 10.0
        self.session.configuration.timeoutIntervalForResource = 15.0
    }
   
    static let shared = NetworkManager()
    let requestBuilder = RequestBuilder()
    private let cache: NSCache = NSCache<NSString, UIImage>()
    
   
    private func downloadImage(url: URL, completion: @escaping (UIImage?, Error?) -> Void) {
        DispatchQueue.main.async {
             UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
       
        session.dataTask(with: url, completionHandler: {(data: Data?, reponse: URLResponse?, error: Error?) in
                var movieImage: UIImage? = UIImage()
                if error != nil {
                    completion(nil,APIError.requestFailed)
                    return
                }
                guard let data = data else {
                    completion(nil,APIError.invalidData)
                    return
                }
                guard let image: UIImage = UIImage(data: data) else {
                    completion(nil,APIError.invalidData)
                    return
                }
                movieImage = image
                if let image = movieImage {
                    self.cache.setObject(image, forKey: url.absoluteString as NSString)
                }
                OperationQueue.main.addOperation {
                    completion(movieImage,nil)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }).resume()
    }
    
    func getImageWithCaching(url: URL, completion: @escaping (UIImage?, Error?) -> Void) {
            if let image = cache.object(forKey: url.absoluteString as NSString) {
                completion(image,nil)
            } else {
                downloadImage(url: url, completion: completion)
            }
        }

    
}
