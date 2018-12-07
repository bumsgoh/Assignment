//
//  APIReference.swift
//  EdWithProject5
//
//  Created by 고상범 on 2018. 8. 22..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

struct APIResponseMovieInformation: Decodable {
    let movies: [MovieInformation]
}
struct APIResponseMovieCommentData: Codable {
    let comments: [MovieCommentData]
}

struct MovieInformation: Decodable {
    
    let title: String
    let id: String
    let grade: Int
    let thumb: String
    let date: String
    let reservationGrade: Int
    let reservationRate: Double
    let userRating: Double
    
    enum CodingKeys: String, CodingKey {
        case title, id, grade, thumb, date
        case reservationGrade = "reservation_grade"
        case reservationRate = "reservation_rate"
        case userRating = "user_rating"
    }
}

struct MovieDetailData: Codable {
    
    let director: String
    let date: String
    let id: String
    let title: String
    let audience: Int
    let actor: String
    let duration: Int
    let synopsis: String
    let genre: String
    let grade: Int
    let image: String
    let reservationGrade: Int
    let reservationRate: Double
    let userRating: Double
    
    enum CodingKeys: String, CodingKey {
        case director, date, id, title, audience, actor, duration, synopsis, genre, grade, image
        case reservationGrade = "reservation_grade"
        case reservationRate = "reservation_rate"
        case userRating = "user_rating"
    }
    
}

struct MovieCommentData: Codable {
    let contents: String
    let timestamp: Double
    let rating: Double
    let movieId: String
    let writer: String
    
    enum CodingKeys: String, CodingKey {
        case contents, timestamp, rating, writer
        case movieId = "movie_id"
    }
}

struct MovieComment: Codable {
    let contents: String
    let timestamp: Double
    let rating: Double
    let movieId: String
    let writer: String
    
    enum CodingKeys: String, CodingKey {
        case contents, timestamp, rating, writer
        case movieId = "movie_id"
    }
}

public enum SortCode: Int {
    case reservationRate
    case quration
    case outDate
}

public func getGradeImage(grade: Int) -> UIImage {
    switch grade {
    case 0:
        return #imageLiteral(resourceName: "ic_allages")
    case 12:
        return #imageLiteral(resourceName: "ic_12")
    case 15:
        return #imageLiteral(resourceName: "ic_15")
    case 19:
        return #imageLiteral(resourceName: "ic_19")
    default:
        return #imageLiteral(resourceName: "ic_list")
        
    }
}












