//
//  ViewController.swift
//  Assignment
//
//  Created by 고상범 on 2018. 12. 7..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dView: DetailMovieInformationView = Bundle.main.loadNibNamed("DetailMovieInformationView", owner: self, options: nil)?.first as! DetailMovieInformationView
        
        dView.translatesAutoresizingMaskIntoConstraints = false
        let data: MovieDetailInformations = MovieDetailInformations(movieImage: #imageLiteral(resourceName: "ic_star_large_full"), movieTitle: "죄와벌", outDate: "2012-03-21", genreAndRunningTime: "135분", movieGradeImage: #imageLiteral(resourceName: "ic_12"), reservationRate: "12%", rating: "7", totalAudience: "3212명", starRating: 7)
       // dView.movieDetailInformations.movieImage = #imageLiteral(resourceName: "ic_star_large_full")
       // dView.movieDetailInformations.movieGradeImage.image = #imageLiteral(resourceName: "ic_12")
        
        self.view.addSubview(dView)
        dView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 8).isActive = true
        dView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        dView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = true
        dView.movieDetailInformations = data
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
