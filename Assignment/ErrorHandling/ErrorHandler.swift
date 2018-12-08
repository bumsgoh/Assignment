//
//  ErrorHandler.swift
//  Assignment
//
//  Created by 고상범 on 2018. 12. 6..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

public enum Result<Value> {
    case success(Value)
    case failure(Error)
}

enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    case urlFailure
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        case .urlFailure: return "url Failure, app is gonna be off"
        }
    }
}

class ErrorHandler {
    
    static let shared = ErrorHandler()
    private init(){}// singleton 이외의 인스턴스화를 금지한다.
    
    func buildErrorAlertController(error: APIError) -> UIAlertController {
        let errorAlertController: UIAlertController
        errorAlertController = UIAlertController(title: "에러",
                                                 message: "데이터를 정상적으로 불러오지 못했습니다 Error: \(error.localizedDescription)",
                                                 preferredStyle: .alert)
        let checkingAction: UIAlertAction = UIAlertAction(title: "확인",
                                                          style: .default,
                                                          handler: nil)
        errorAlertController.addAction(checkingAction)
        return errorAlertController
    }
}
