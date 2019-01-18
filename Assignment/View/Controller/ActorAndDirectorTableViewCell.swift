//
//  ActorAndDirectorTableViewCell.swift
//  Assignment
//
//  Created by 고상범 on 2018. 12. 7..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class ActorAndDirectorTableViewCell: UITableViewCell {
    
    public let directorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private let headText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "감독/출연"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let directorText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "감독"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    public let directorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private let actorText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "출연"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    public let actorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    public let tableViewHeadView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private let tableViewHeadText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "한줄평"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    public let tableViewHeadButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "btn_compose"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        UISetUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ActorAndDirectorTableViewCell {
    
    //MARK:- UI Setting
    private func UISetUp() {
        contentView.addSubview(directorView)
        directorView.addSubview(headText)
        directorView.addSubview(directorText)
        directorView.addSubview(directorLabel)
        directorView.addSubview(actorText)
        directorView.addSubview(actorLabel)
        
        contentView.addSubview(tableViewHeadView)
        tableViewHeadView.addSubview(tableViewHeadText)
        tableViewHeadView.addSubview(tableViewHeadButton)
        
        directorView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4).isActive = true
        directorView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        directorView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        headText.topAnchor.constraint(equalTo: directorView.topAnchor, constant: 8).isActive = true
        headText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
        
        directorText.topAnchor.constraint(equalTo: headText.bottomAnchor, constant: 8).isActive = true
        directorText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18).isActive = true
        directorLabel.topAnchor.constraint(equalTo: headText.bottomAnchor, constant: 8).isActive = true
        directorLabel.leadingAnchor.constraint(equalTo: directorText.trailingAnchor, constant: 8).isActive = true
        
        actorText.topAnchor.constraint(equalTo: directorText.bottomAnchor, constant: 8).isActive = true
        actorText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18).isActive = true
        actorLabel.topAnchor.constraint(equalTo: directorText.bottomAnchor, constant: 8).isActive = true
        actorLabel.leadingAnchor.constraint(equalTo: actorText.trailingAnchor, constant: 8).isActive = true
        actorLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8).isActive = true
        
        
        tableViewHeadView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        tableViewHeadView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        tableViewHeadView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        tableViewHeadText.topAnchor.constraint(equalTo: tableViewHeadView.topAnchor, constant: 8).isActive = true
        tableViewHeadText.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        tableViewHeadButton.topAnchor.constraint(equalTo: tableViewHeadView.topAnchor, constant: 8).isActive = true
        tableViewHeadButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        
    }
}
