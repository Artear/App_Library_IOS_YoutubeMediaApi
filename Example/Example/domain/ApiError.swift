
//
//  ApiError.swift
//  YoutubeMediaApi_Example
//
//  Created by Jose Luis Sagredo on 6/12/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

public enum ApiError: Error {
    case unidentifier
    case missingParameters
    case empty
}

extension ApiError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unidentifier: return NSLocalizedString("unknown identifier", comment: "Api error")
        case .missingParameters: return NSLocalizedString("Missing parameters", comment: "Api error")
        case .empty: return NSLocalizedString("Empty", comment: "Api error")
        }
    }
}

