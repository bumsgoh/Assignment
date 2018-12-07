//
//  MainTableViewCell.swift
//  EdWithProject5
//
//  Created by 고상범 on 2018. 8. 18..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        UISetUp()
      
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("error")
    }
}

extension MainTableViewCell {
    
    override func prepareForReuse() {
        self.movieImageView.image = #imageLiteral(resourceName: "img_placeholder")
        self.titleLabel.text = ""
        self.gradeImageView.image = nil
        self.infoLabel.text = ""
        self.outDateLabel.text = ""
    }
    
    func UISetUp() {
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(gradeImageView)
        self.contentView.addSubview(outDateLabel)
        self.contentView.addSubview(movieImageView)
        self.contentView.addSubview(infoLabel)
        
        self.movieImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.movieImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8).isActive = true
        self.movieImageView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.9).isActive = true
        
        self.titleLabel.leadingAnchor.constraint(equalTo: self.movieImageView.trailingAnchor, constant: 8).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: self.movieImageView.topAnchor, constant: 8).isActive = true
        
        self.gradeImageView.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 4).isActive = true
        self.gradeImageView.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor).isActive = true
        
        self.infoLabel.leadingAnchor.constraint(equalTo: self.movieImageView.trailingAnchor, constant: 8).isActive = true
        self.infoLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8).isActive = true
        
        self.outDateLabel.leadingAnchor.constraint(equalTo: self.movieImageView.trailingAnchor, constant: 8).isActive = true
        self.outDateLabel.topAnchor.constraint(equalTo: self.infoLabel.bottomAnchor, constant: 8).isActive = true
        
        
    }
}
