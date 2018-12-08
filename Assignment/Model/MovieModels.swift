//
//  MovieDetailInformations.swift
//  Assignment
//
//  Created by 고상범 on 2018. 12. 7..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit
struct MovieModels {
    
    struct MovieInformations {
        let movieImage: UIImage
        let movieTitle: String
        let outDate: String
        let genreAndRunningTime: String
        let movieGradeImage: UIImage
        let reservationRate: String
        let totalAudience: String
        let starRating: Float
        
        init(movieImage: UIImage, movieTitle: String, outDate: String, genreAndRunningTime: String, movieGradeImage: UIImage, reservationRate: String, totalAudience: String, starRating: Float) {
            
            self.movieImage = movieImage
            self.movieTitle = movieTitle
            self.outDate = outDate
            self.genreAndRunningTime = genreAndRunningTime
            self.movieGradeImage = movieGradeImage
            self.reservationRate = reservationRate
            self.totalAudience = totalAudience
            self.starRating = starRating
            
        }
        init() {
            self.movieImage = UIImage.init()
            self.movieTitle = ""
            self.outDate = ""
            self.genreAndRunningTime = ""
            self.movieGradeImage = UIImage.init()
            self.reservationRate = ""
            self.totalAudience = ""
            self.starRating = 0
        }
    }
    
    struct MovieDetailInformations {
        
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
        
        init(director: String, date: String, id: String, title: String, audience: Int, actor: String, duration: Int, synopsis: String, genre: String,  grade: Int, image: String, reservationGrade: Int, reservationRate: Double,  userRating: Double) {
            self.director = director
            self.date = date
            self.id = id
            self.title = title
            self.audience = audience
            self.actor = actor
            self.duration = duration
            self.synopsis = synopsis
            self.genre = genre
            self.grade = grade
            self.image = image
            self.reservationGrade = reservationGrade
            self.reservationRate = reservationRate
            self.userRating = userRating
        }
        
        init() {
            self.director = ""
            self.date = ""
            self.id = ""
            self.title = ""
            self.audience = 0
            self.actor = ""
            self.duration = 0
            self.synopsis = ""
            self.genre = ""
            self.grade = 0
            self.image = ""
            self.reservationGrade = 0
            self.reservationRate = 0
            self.userRating = 0
        }
    }

    struct MovieCommentData {
        
        let contents: String
        let timestamp: Double
        let rating: Double
        let movieId: String
        let writer: String
        
        init(contents: String, timestamp: Double, rating: Double, movieId: String, writer: String) {
            self.contents = contents
            self.timestamp = timestamp
            self.rating = rating
            self.movieId = movieId
            self.writer = writer
        }
        
        init() {
            self.contents = ""
            self.timestamp = 0
            self.rating = 0
            self.movieId = ""
            self.writer = ""
        }
    }
}
