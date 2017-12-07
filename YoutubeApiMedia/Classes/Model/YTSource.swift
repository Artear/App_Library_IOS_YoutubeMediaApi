//
//  Source.swift
//  YoutubeApiMedia
//
//  Created by Jose Luis Sagredo on 7/12/17.
//

import UIKit

class YTSource {
    enum QualityType : String {
        case hd720
        case medium
        case small
        case adaptative
    }
    
    var quality : QualityType
    var url : String
    
    init(url : String, qualityType : QualityType = .adaptative) {
        self.quality = qualityType
        self.url = url
    }
}

