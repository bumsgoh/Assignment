//
//  MovieDetailInformations.swift
//  Assignment
//
//  Created by 고상범 on 2018. 12. 7..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

struct MovieDetailInformations {
    
    let movieImage: UIImage
    let movieTitle: String
    let outDate: String
    let genreAndRunningTime: String
    let movieGradeImage: UIImage
    let reservationRate: String
    let rating: String
    let totalAudience: String
    let starRating: Float
    
    init(movieImage: UIImage, movieTitle: String, outDate: String, genreAndRunningTime: String, movieGradeImage: UIImage, reservationRate: String, rating: String, totalAudience: String, starRating: Float) {
        
        self.movieImage = movieImage
        self.movieTitle = movieTitle
        self.outDate = outDate
        self.genreAndRunningTime = genreAndRunningTime
        self.movieGradeImage = movieGradeImage
        self.reservationRate = reservationRate
        self.rating = rating
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
        self.rating = ""
        self.totalAudience = ""
        self.starRating = 0
    }
}
