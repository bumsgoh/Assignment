//
//  RequestBuilder.swift
//  Assignment
//
//  Created by 고상범 on 2018. 12. 7..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit



class RequestBuilder {
    
    let session = URLSession.shared
    
    func makeRequest(form: MovieAPI, errorOcurredBlock: (() -> ())) -> URLRequest {
        guard let url: URL = form.urlComponents.url else {
            errorOcurredBlock()
            fatalError()
                }
        let request = URLRequest(url: url)
        return request
    }
}









