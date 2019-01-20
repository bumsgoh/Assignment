//
//  SynopsisTableViewCell.swift
//  Assignment
//
//  Created by 고상범 on 2018. 12. 7..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class SynopsisTableViewCell: UITableViewCell {
    
    public let synopsisLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "줄거리"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    public let synopsisTextView: UITextView = {
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
}

extension SynopsisTableViewCell {
    
    //MARK:- UI Setting
    private func UISetUp() {
        contentView.addSubview(synopsisLabel)
        contentView.addSubview(synopsisTextView)
        
        synopsisLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        synopsisLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
        
        synopsisTextView.topAnchor.constraint(equalTo: synopsisLabel.bottomAnchor, constant: 4).isActive = true
        synopsisTextView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -8).isActive = true
        synopsisTextView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 8).isActive = true
        synopsisTextView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -8).isActive = true
    }
}
