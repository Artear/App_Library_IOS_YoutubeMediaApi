//
//  YoutubeModel.swift
//  YoutubeApiMedia
//
//  Created by Mauro Gonzalez on 05/12/2017.
//

import Foundation

class YoutubeModel {
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

