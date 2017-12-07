//
//  YoutubeMedia.swift
//  YoutubeApiMedia
//
//  Created by Mauro Gonzalez on 05/12/2017.
//

import Foundation

class YoutubeMedia {
	var id:String
	var title:String?
	var keywords:[String] = [String]()
	var media : Media!
	
	init(id:String) {
		self.id = id
	}
}
