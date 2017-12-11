//
//  YoutubeMediaApiError.swift
//  Alamofire
//
//  Created by Jose Luis Sagredo on 11/12/17.
//

import UIKit

enum YoutubeMediaApiError: Error {
    case unknown
    case withOutData
    case withQueryItems
    case serverError(code:Int, reason:String)
}

extension YoutubeMediaApiError: LocalizedError{
    // TODO: add error description
    public var errorDescription: String? {
        switch self {
        case .unknown: return NSLocalizedString("unknown identifier", comment: "Youtube Error")
        case .withOutData: return NSLocalizedString("withOutData", comment: "Youtube Error")
        case .withQueryItems: return NSLocalizedString("withQueryItems", comment: "Youtube Error")
        case .serverError(let code , let reason):
            return NSLocalizedString("[\(code)] \(reason)", comment: "Youtube Error")
        }
    }
}
