//
//  NetworkManager.swift
//  EdWithProject5
//
//  Created by 고상범 on 2018. 8. 29..
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
    }
   
    static let shared = NetworkManager()
    let requestBuilder = RequestBuilder()
    let cache: NSCache = NSCache<NSString, UIImage>()
    
   
    func downloadImage(url: URL, completion: @escaping (UIImage?, Error?) -> Void) {
        DispatchQueue.main.async {
             UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
       
        let imageLoadError: NSError = NSError(domain: "imageLoadFailed", code: 0, userInfo: nil)
        URLSession.shared.dataTask(with: url, completionHandler: {(data: Data?, reponse: URLResponse?, error: Error?) in
                var movieImage: UIImage? = UIImage()
                if let error = error {
                    print(error.localizedDescription)
                    completion(nil,imageLoadError)
                    return
                }
                guard let data = data else {
                    completion(nil,error)
                    return
                }
                guard let image: UIImage = UIImage(data: data) else {
                    completion(nil,error)
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
    
    func getImage(url: URL, completion: @escaping (UIImage?, Error?) -> Void) {// let cache: NSCache = NSCache<NSString, UIImage>()
            if let image = cache.object(forKey: url.absoluteString as NSString) {
                completion(image,nil)
            } else {
                downloadImage(url: url, completion: completion)
            }
        }

    
}
