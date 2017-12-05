//
//  YoutubeMedia.swift
//  YoutubeApiMedia
//
//  Created by Mauro Gonzalez on 05/12/2017.
//

import Foundation

class YoutubeMedia {
	var id:String
	var title:String = ""
	var keywords:[String] = [String]()
	
	init(id:String) {
		self.id = id
	}
	
	func printModel() {
		print("\(self.title)")
		print("keywords: \(self.keywords)")
	}
}


class Media{
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


class Source{
	enum QualityType {
		case hd720
		case medium
		case small
		case adaptative
	}
	var quality : QualityType
	var url : String
	
	init(qualityType : QualityType, url : String) {
		self.quality = qualityType
		self.url = url
	}
}
