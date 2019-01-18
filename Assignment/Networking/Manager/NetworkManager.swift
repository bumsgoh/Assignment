//
//  NetworkManager.swift
//  Assignment
//
//  Created by 고상범 on 2018. 12. 7..
//  Copyright © 2018년 고상범. All rights reserved.
//


import UIKit

class NetworkManager: APIService {
   
    internal let session: URLSession
    
    private init(configuration: URLSessionConfiguration) {
        session = URLSession(configuration: configuration)
    }
    
    private convenience init() {
        self.init(configuration: .default)
        self.session.configuration.timeoutIntervalForRequest = 10.0
        self.session.configuration.timeoutIntervalForResource = 15.0
    }
   /* NetworkManger 클래스를 싱글턴으로 이용할 수 있도록 타입 프로퍼티로 선언한 뒤 인스턴스를 할당해 주었습니다. 또한 이니셜라이저를 private 접근 지정자로 설정하여 클래스 외부에서는 인스턴스화 할 수 없도록 처리했습니다.
     */
    static let shared = NetworkManager()
    let requestBuilder = RequestBuilder()
    private let cache = NSCache<NSString, UIImage>()
    
    private func downloadImage(url: URL, completion: @escaping (UIImage?, Error?) -> Void) {
        DispatchQueue.main.async {
             UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
       
        session.dataTask(with: url, completionHandler: { (data, reponse, error) in
            defer {
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
            var movieImage = UIImage()
            if error != nil {
                completion(nil,APIError.requestFailed)
                return
            }
            guard let data = data else {
                completion(nil,APIError.invalidData)
                return
            }
            guard let image = UIImage(data: data) else {
                completion(nil,APIError.invalidData)
                return
            }
            movieImage = image
            
            self.cache.setObject(image, forKey: url.absoluteString as NSString)
            OperationQueue.main.addOperation {
                completion(movieImage,nil)
            }
        }).resume()
    }
    //캐싱 기능을 사용하여 한번 받아온 이미지는 다시 네트워킹을 하지 않도록 처리하였습니다.
    func getImageWithCaching(url: URL, completion: @escaping (UIImage?, Error?) -> Void) {
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            completion(image,nil)
        } else {
            downloadImage(url: url, completion: completion)
        }
    }
}
