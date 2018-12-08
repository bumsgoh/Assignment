//
//  CommentTableViewCell.swift
//  EdWithProject5
//
//  Created by 고상범 on 2018. 8. 27..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    var mutableStarImageArray: [UIImageView] = [UIImageView()]
    var starRatingPoint: Float = 0 {
        didSet {
            starRatingPoint = starRatingPoint/2
            refreshingStarRatingView()
        }
    }
    
    var movieCommentData: MovieCommentData = MovieCommentData() {
        didSet {
            setDataToViews()
        }
    }
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "YYYY-MM-dd a hh:mm"
        return formatter
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        getAllArrangedSubviews()
    }
    //MARK:- IBOutlets
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var starRatingStackView: UIStackView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
}

extension CommentTableViewCell {
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
    
    private func getAllArrangedSubviews() {
        mutableStarImageArray = starRatingStackView.arrangedSubviews.compactMap {
            guard let starImageView: UIImageView = $0 as? UIImageView else {
                
                return UIImageView()
                
            }
            return starImageView
        }
    }

    override func prepareForReuse() {
        self.userImageView.image = #imageLiteral(resourceName: "ic_user_loading")
        self.userIdLabel.text = ""
        self.timeLabel.text = ""
        self.commentTextView.text = ""
    }
    
   private func setDataToViews() {
        userImageView.image = #imageLiteral(resourceName: "ic_user_loading")
        userIdLabel.text = movieCommentData.writer
        starRatingPoint = Float(movieCommentData.rating)
        let date = Date(timeIntervalSince1970: movieCommentData.timestamp)
        timeLabel.text = formatter.string(from: date)
        commentTextView.text = movieCommentData.contents
    }
    
    
    
    
}


