//
//  RequestBuilder.swift
//  Assignment
//
//  Created by 고상범 on 2018. 12. 7..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit



class RequestBuilder {

    func makeRequest(form: MovieAPI, errorOcurredBlock: (() -> ())) -> URLRequest {
        guard let url = form.urlComponents.url else {
            errorOcurredBlock()
            fatalError()
                }
        
        return URLRequest(url: url)
    }
}









