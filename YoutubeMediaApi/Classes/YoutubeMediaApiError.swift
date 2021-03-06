//
//  YoutubeMediaApiError.swift
//  Alamofire
//
//  Created by Jose Luis Sagredo on 11/12/17.
//

import UIKit

public enum YoutubeMediaApiError: Error {
    case unknown
    case withOutData
    case withQueryItems
	case invalidSources
    case serverError(code:Int, reason:String)
}

extension YoutubeMediaApiError: LocalizedError{
    // TODO: add error description
    public var errorDescription: String? {
        switch self {
        case .unknown: return NSLocalizedString("unknown identifier", comment: "Youtube Error")
        case .withOutData: return NSLocalizedString("withOutData", comment: "Youtube Error")
        case .withQueryItems: return NSLocalizedString("withQueryItems", comment: "Youtube Error")
		case .invalidSources: return NSLocalizedString("invalidSources", comment: "Youtube Error")
        case .serverError(_, let reason):
            return NSLocalizedString(reason, comment: "Youtube Error")
        }
    }
    
    public var errorCode: Int {
        switch self {
        case .unknown: return 0
        case .withOutData: return 1
        case .withQueryItems: return 2
		case .invalidSources: return 3
        case .serverError(let code , _):
            return code
        }
    }
}
