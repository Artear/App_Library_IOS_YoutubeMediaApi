//
//  YoutubeMedia.swift
//  YoutubeMediaApi
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
	
	public func getId() ->String{
		return self.id
	}

	public func getTitle() ->String?{
		return self.title
	}
	
	public func getKeyboards() -> [String]{
		return self.keywords
	}

	public func getMedia() -> YTMedia? {
		return self.media
	}
	
	public func getType() -> Types{
		return self.type
	}
}
