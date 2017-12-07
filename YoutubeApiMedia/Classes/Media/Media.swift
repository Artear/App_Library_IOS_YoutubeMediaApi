//
//  Media.swift
//  YoutubeApiMedia
//
//  Created by Jose Luis Sagredo on 7/12/17.
//

import UIKit

class Media {
    enum Types {
        case live
        case video
    }
    
    var type : Types
    var source = [Source]()
    
    init(type : Types, source : [Source]) {
        self.type = type
        self.source = source
    }
}

