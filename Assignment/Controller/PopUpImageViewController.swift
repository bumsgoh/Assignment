//
//  PopUpImageViewController.swift
//  EdWithProject5
//
//  Created by 고상범 on 2018. 9. 1..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class PopUpImageViewController: UIViewController {
    
    let fullScreenImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
   lazy var imageViewGestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(imageClicked))
        return recognizer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetUp()
    }
    
    @objc func imageClicked() {
        self.dismiss(animated: false, completion: nil)
    }
    
    func UISetUp() {
        
        self.view.addSubview(fullScreenImageView)
        
        fullScreenImageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        fullScreenImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        fullScreenImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        fullScreenImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        fullScreenImageView.addGestureRecognizer(imageViewGestureRecognizer)
        
    }
}
