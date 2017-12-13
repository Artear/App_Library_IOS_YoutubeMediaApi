//
//  Source.swift
//  YoutubeApiMedia
//
//  Created by Jose Luis Sagredo on 7/12/17.
//

import UIKit

public class YTSource {
    public enum QualityType : String {
        case hd720
        case medium
        case small
        case adaptative
    }
    
    var quality : QualityType
    var url : String
    
    public init(url : String, qualityType : QualityType = .adaptative) {
        self.quality = qualityType
        self.url = url
    }
	
	public func getQuality() -> QualityType{
		return self.quality
	}
	
	public func getURL() -> String{
		return self.url
	}
}

