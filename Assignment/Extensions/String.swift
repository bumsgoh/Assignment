//
//  String.swift
//  Assignment
//
//  Created by 고상범 on 2018. 12. 7..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

extension String {
    func toBoldString(with size: Int) -> NSMutableAttributedString {
        let attribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
        let attributedString = NSMutableAttributedString(string: self, attributes: attribute)
        return attributedString
    }
}
