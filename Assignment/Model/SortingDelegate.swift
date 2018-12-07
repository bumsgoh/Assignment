//
//  SortingProtocol.swift
//  EdWithProject5
//
//  Created by 고상범 on 2018. 8. 23..
//  Copyright © 2018년 고상범. All rights reserved.
//

import Foundation

protocol NetworkServiceDelegate: class {
    func didCompleteRequest()
}

protocol SortingDelegate: class {
   func didMovieDataChange()
}

public enum SortCode: Int {
    case reservationRate
    case quration
    case outDate
}

