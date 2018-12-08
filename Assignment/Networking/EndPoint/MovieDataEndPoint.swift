//
//  MovieDataEndPoint.swift
//  Assignment
//
//  Created by 고상범 on 2018. 12. 7..
//  Copyright © 2018년 고상범. All rights reserved.
//

import Foundation

var baseURL: String {
    return "http://connect-boxoffice.run.goorm.io"
}

var sortCode: SortCode = .reservationRate
var movieId: String = ""

public enum MovieAPI {
    case movieList(sortBy: SortCode)
    case movieDetailData(movieId: String)
    case movieDataIncludingComments(movieId: String)
    case movieComments

    var path: String {
        switch self {
        case .movieList(let code):
            sortCode = code
            return "/movies"
        case .movieDetailData(let id):
            movieId = id
            return "/movie"
        case .movieDataIncludingComments(let id):
            movieId = id
            return "/comments"
        case .movieComments:
            return "/comment"
        }
    }
    
    var urlComponents: URLComponents {
        if var components = URLComponents(string: baseURL) {
            components.path = path
            switch path {
            case "/movies":
                components.queryItems = [URLQueryItem(name: "order_type", value: "\(sortCode.rawValue)")]
                
            case "/movie":
                 components.queryItems = [URLQueryItem(name: "id", value: movieId)]
                
            case "/comments":
                 components.queryItems = [URLQueryItem(name: "movie_id", value: movieId)]
        
            default:
                components.queryItems = [URLQueryItem(name: "movie_id", value: movieId)]
            }
            return components
        } else {
            
            fatalError("failed to make URL")
        }
    }
}




