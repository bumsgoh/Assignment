//
//  MainCollectionViewCell.swift
//  EdWithProject5
//
//  Created by 고상범 on 2018. 8. 27..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.black
        return label
    }()
    let gradeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.black
        return label
    }()
    
    let outDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.black
        return label
    }()
    
    let movieImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        UISetUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("error")
        }
    }

extension MainCollectionViewCell {
    
    override func prepareForReuse() {
        self.movieImageView.image = #imageLiteral(resourceName: "ic_user_loading")
        self.gradeImageView.image = nil
        self.titleLabel.text = ""
        self.infoLabel.text = ""
        self.outDateLabel.text = ""
    }
    
    func UISetUp() {
        self.contentView.addSubview(movieImageView)
        self.movieImageView.addSubview(gradeImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(outDateLabel)
        self.contentView.addSubview(infoLabel)
 
        self.movieImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        self.movieImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.movieImageView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.8).isActive = true
        self.movieImageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 1).isActive = true
    
        self.gradeImageView.trailingAnchor.constraint(equalTo: self.movieImageView.trailingAnchor, constant: -8).isActive = true
        self.gradeImageView.topAnchor.constraint(equalTo: self.movieImageView.topAnchor, constant: 18).isActive = true
        
        self.titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: self.movieImageView.bottomAnchor, constant: 8).isActive = true
        
        self.infoLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 4).isActive = true
        self.infoLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8).isActive = true
        
        self.outDateLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 4).isActive = true
        self.outDateLabel.topAnchor.constraint(equalTo: self.infoLabel.bottomAnchor, constant: 8).isActive = true
    }
}




