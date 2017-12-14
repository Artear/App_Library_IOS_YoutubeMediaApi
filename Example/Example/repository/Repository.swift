//
//  Repository.swift
//  YoutubeMediaApi_Example
//
//  Created by Jose Luis Sagredo on 6/12/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

public class Repository {
    static let domine = "https://www.googleapis.com/youtube/"
    private init() {}
}

extension Repository {
    enum v3 {
        case videos
        func toString() -> String {
            switch self {
            case .videos:
                return "\(Repository.domine)v3/videos"
            }
        }
    }
}
