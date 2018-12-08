//
//  DetailMovieInformationView.swift
//  Assignment
//
//  Created by 고상범 on 2018. 12. 7..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class DetailMovieInformationView: UIView {
    
    var mutableStarImageArray: [UIImageView] = [UIImageView()]
    var starRatingPoint: Float = 0 {
        didSet {
            starRatingPoint = starRatingPoint/2
            refreshingStarRatingView()
        }
    }
    var movieDetailInformations: MovieDetailData = MovieDetailData() {
        didSet {
           setDataToViews()
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let formatter =  NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    private func getAllArrangedSubviews() {
        mutableStarImageArray = starRatingStackView.arrangedSubviews.compactMap {
            guard let starImageView: UIImageView = $0 as? UIImageView else {
                
                return UIImageView()
                
            }
            return starImageView
        }
    }
    
   private func refreshingStarRatingView() {
        for i in self.mutableStarImageArray.indices {
            let starImageView: UIImageView? = self.mutableStarImageArray[i]
            
            if (self.starRatingPoint >= Float(i+1)) {
                starImageView?.image = #imageLiteral(resourceName: "ic_star_label")
            } else if (self.starRatingPoint > Float(i) && self.starRatingPoint < Float(i+1)) {
                starImageView?.image = #imageLiteral(resourceName: "ic_star_large_half")
            } else {
                starImageView?.image = #imageLiteral(resourceName: "ic_star_large")
            }
        }
    }
    
   private func setDataToViews() {
        let movieDetail = self.movieDetailInformations
        movieTitleLabel.text = movieDetail.title
        outDateLabel.text = movieDetail.date
        genreAndRunningTimeLabel.text = "\(movieDetail.genre) \(movieDetail.duration)분"
        
        let reservationText: NSMutableAttributedString = NSMutableAttributedString()
        reservationText.append("예매율".toBoldString(of: 20))
        let reservationNormalString = NSMutableAttributedString(string:"\n\n\(movieDetail.reservationRate)")
        reservationText.append(reservationNormalString)
        reservationRateLabel.attributedText = reservationText
        
        let ratingText: NSMutableAttributedString = NSMutableAttributedString()
        ratingText.append("평점".toBoldString(of: 20))
        let ratingNormalString = NSMutableAttributedString(string:"\n\(movieDetail.userRating)")
        ratingText.append(ratingNormalString)
        ratingLabel.attributedText = ratingText
        
        let audienceText: NSMutableAttributedString = NSMutableAttributedString()
        audienceText.append("총 관객수".toBoldString(of: 20))
        guard let audienceNumber: String = self.numberFormatter.string(from: movieDetail.audience as NSNumber) else {
            
            return
            
        }
        let audienceNormalString = NSMutableAttributedString(string:"\n\n\(audienceNumber)")
        audienceText.append(audienceNormalString)
        totalAudienceLabel.attributedText = audienceText
        starRatingPoint = Float(movieDetail.userRating)
        movieGradeImageView.image = getGradeImage(grade: movieDetail.grade)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        getAllArrangedSubviews()
    }
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var outDateLabel: UILabel!
    @IBOutlet weak var genreAndRunningTimeLabel: UILabel!
    @IBOutlet weak var movieGradeImageView: UIImageView!
    @IBOutlet weak var reservationRateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var totalAudienceLabel: UILabel!
    @IBOutlet weak var starRatingStackView: UIStackView!
}

