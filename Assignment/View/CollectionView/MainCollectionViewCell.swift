//
//  MainCollectionViewCell.swift
//  Assignment
//
//  Created by 고상범 on 2018. 12. 7..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
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
        movieImageView.image = #imageLiteral(resourceName: "ic_user_loading")
        gradeImageView.image = nil
        titleLabel.text = ""
        infoLabel.text = ""
        outDateLabel.text = ""
    }
    
    //MARK:- UI Setting
    private func UISetUp() {
        contentView.addSubview(movieImageView)
        movieImageView.addSubview(gradeImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(outDateLabel)
        contentView.addSubview(infoLabel)
        
        movieImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        movieImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8).isActive = true
        movieImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1).isActive = true
        
        gradeImageView.trailingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: -8).isActive = true
        gradeImageView.topAnchor.constraint(equalTo: movieImageView.topAnchor, constant: 32).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 8).isActive = true
        
        infoLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 4).isActive = true
        infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        
        outDateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 4).isActive = true
        outDateLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 8).isActive = true
    }
}
