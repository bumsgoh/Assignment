//
//  MainTableViewCell.swift
//  Assignment
//
//  Created by 고상범 on 2018. 12. 7..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.black
        return label
    }()
    
    public let gradeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    public let infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.black
        return label
    }()
    
    public let outDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.black
        return label
    }()
    
    public let movieImageView: UIImageView = {
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
    
    //MARK:- UI Setting
    private func UISetUp() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(gradeImageView)
        contentView.addSubview(outDateLabel)
        contentView.addSubview(movieImageView)
        contentView.addSubview(infoLabel)
        
        movieImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        movieImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 8).isActive = true
        titleLabel.topAnchor.constraint(equalTo: movieImageView.topAnchor, constant: 8).isActive = true
        
        gradeImageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 4).isActive = true
        gradeImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        
        infoLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 8).isActive = true
        infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        
        outDateLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 8).isActive = true
        outDateLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 8).isActive = true
    }
}
