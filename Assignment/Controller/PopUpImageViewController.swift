//
//  PopUpImageViewController.swift
//  Assignment
//
//  Created by 고상범 on 2018. 12. 7..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class PopUpImageViewController: UIViewController {
    
    public let fullScreenImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var imageViewGestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(imageClicked))
        return recognizer
    }()
}

extension PopUpImageViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetUp()
    }
    
    @objc func imageClicked() {
        dismiss(animated: false, completion: nil)
    }
    
    private func UISetUp() {
        
        view.addSubview(fullScreenImageView)
        
        fullScreenImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        fullScreenImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        fullScreenImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        fullScreenImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        fullScreenImageView.addGestureRecognizer(imageViewGestureRecognizer)
        
    }
}
