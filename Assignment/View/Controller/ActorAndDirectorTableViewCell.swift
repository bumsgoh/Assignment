//
//  ActorAndDirectorTableViewCell.swift
//  Assignment
//
//  Created by 고상범 on 2018. 12. 7..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class ActorAndDirectorTableViewCell: UITableViewCell {
    
    let directorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let headText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "감독/출연"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let directorText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "감독"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let directorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let actorText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "출연"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let actorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
   
    let tableViewHeadView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let tableViewHeadText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "한줄평"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    let tableViewHeadButton: UIButton = {
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
    
    //MARK:- UI Setting
   private func UISetUp() {
        self.contentView.addSubview(directorView)
        self.directorView.addSubview(headText)
        self.directorView.addSubview(directorText)
        self.directorView.addSubview(directorLabel)
        self.directorView.addSubview(actorText)
        self.directorView.addSubview(actorLabel)
        
        self.contentView.addSubview(tableViewHeadView)
        self.tableViewHeadView.addSubview(tableViewHeadText)
        self.tableViewHeadView.addSubview(tableViewHeadButton)
        
        self.directorView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 4).isActive = true
        self.directorView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.directorView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        self.headText.topAnchor.constraint(equalTo: self.directorView.topAnchor, constant: 8).isActive = true
        self.headText.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12).isActive = true
        
        self.directorText.topAnchor.constraint(equalTo: self.headText.bottomAnchor, constant: 8).isActive = true
        self.directorText.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 18).isActive = true
        self.directorLabel.topAnchor.constraint(equalTo: self.headText.bottomAnchor, constant: 8).isActive = true
        self.directorLabel.leadingAnchor.constraint(equalTo: self.directorText.trailingAnchor, constant: 8).isActive = true
        
        self.actorText.topAnchor.constraint(equalTo: self.directorText.bottomAnchor, constant: 8).isActive = true
        self.actorText.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 18).isActive = true
        self.actorLabel.topAnchor.constraint(equalTo: self.directorText.bottomAnchor, constant: 8).isActive = true
        self.actorLabel.leadingAnchor.constraint(equalTo: self.actorText.trailingAnchor, constant: 8).isActive = true
        
        
        self.tableViewHeadView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        self.tableViewHeadView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.tableViewHeadView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.tableViewHeadText.topAnchor.constraint(equalTo: self.tableViewHeadView.topAnchor, constant: 8).isActive = true
        self.tableViewHeadText.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.tableViewHeadButton.topAnchor.constraint(equalTo: self.tableViewHeadView.topAnchor, constant: 8).isActive = true
        self.tableViewHeadButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8).isActive = true
        
    }

}
