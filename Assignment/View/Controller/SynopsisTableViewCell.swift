//
//  SynopsisTableViewCell.swift
//  EdWithProject5
//
//  Created by 고상범 on 2018. 9. 2..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class SynopsisTableViewCell: UITableViewCell {
    
    let synopsisLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "줄거리"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let synopsisTextView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 16)
        view.backgroundColor = UIColor.white
        view.isScrollEnabled = false
        view.isEditable = false
        view.sizeToFit()
        return view
    }()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.frame = CGRect(x: 0, y: 0, width: 300, height: 250)
        UISetUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- UI Setting
   private func UISetUp() {
        self.contentView.addSubview(synopsisLabel)
        self.contentView.addSubview(synopsisTextView)
        
        self.synopsisLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12).isActive = true
        self.synopsisLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12).isActive = true
        
        self.synopsisTextView.topAnchor.constraint(equalTo: self.synopsisLabel.bottomAnchor, constant: 4).isActive = true
        self.synopsisTextView.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor, constant: -8).isActive = true
        self.synopsisTextView.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor, constant: 8).isActive = true
        self.synopsisTextView.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor, constant: -8).isActive = true
    }
    
    

}

