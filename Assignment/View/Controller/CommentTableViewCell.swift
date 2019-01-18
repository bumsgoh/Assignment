//
//  CommentTableViewCell.swift
//  Assignment
//
//  Created by 고상범 on 2018. 12. 7..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    private var mutableStarImageArray = [UIImageView]()
    private var starRatingPoint: Float = 0 {
        didSet {
            starRatingPoint = starRatingPoint/2
            refreshingStarRatingView()
        }
    }
    
    public var movieCommentData: MovieCommentData = MovieCommentData() {
        didSet {
            setDataToViews()
        }
    }
    
    private let formatter: DateFormatter = {
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
        for (i, v) in mutableStarImageArray.enumerated() {
            let starImageView = v
            
            if starRatingPoint >= Float(i+1) {
                starImageView.image = #imageLiteral(resourceName: "ic_star_label")
            } else if starRatingPoint > Float(i) && starRatingPoint < Float(i+1) {
                starImageView.image = #imageLiteral(resourceName: "ic_star_large_half")
            } else {
                starImageView.image = #imageLiteral(resourceName: "ic_star_large")
            }
        }
    }
    
    private func getAllArrangedSubviews() {
        mutableStarImageArray = starRatingStackView.arrangedSubviews.compactMap {
            guard let starImageView = $0 as? UIImageView else {
                
                return UIImageView()
                
            }
            return starImageView
        }
    }
    
    override func prepareForReuse() {
        userImageView.image = #imageLiteral(resourceName: "ic_user_loading")
        userIdLabel.text = ""
        timeLabel.text = ""
        commentTextView.text = ""
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
