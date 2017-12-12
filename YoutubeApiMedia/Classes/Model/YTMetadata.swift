//
//  YoutubeMedia.swift
//  YoutubeApiMedia
//
//  Created by Mauro Gonzalez on 05/12/2017.
//

import Foundation

public class YTMetadata {
    public enum Types {
        case live
        case video
    }
    
	var id:String
	var title:String?
	var keywords:[String] = [String]()
	var media:YTMedia?
    var type:Types = .video
	
	public init(id:String) {
		self.id = id
	}
}
