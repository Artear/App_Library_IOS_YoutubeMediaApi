//
//  YoutubeApiMedia.swift
//  Nimble
//
//  Created by Mauro Gonzalez on 05/12/2017.
//

import Foundation

public class YoutubeMediaApi {
	enum errorType: Error {
		case unknown
		case withOutData
		case withQueryItems
		case outsideBroadcast
		case notHls
	}
	
	var id:String!
	var content:String?
	
	init(id:String) {
		self.id = id
	}
	
	func loadMock() throws {
		guard let fileURL = Bundle.main.url(forResource: self.id, withExtension: "txt") else {
			throw errorType.unknown
		}
		self.content = try String(contentsOf: fileURL, encoding: String.Encoding.utf8).trimmingCharacters(in: .whitespacesAndNewlines)
	}
	
	
	func parse() throws -> YoutubeModel {
		guard let params = self.content else {
			throw errorType.withOutData
		}
		
		guard
			let paramsYoutube = URLComponents(string: "http://yt?\(params)"),
			let paramsYoutubeItems = paramsYoutube.queryItems
			else {
				throw errorType.withQueryItems
		}
		
		let YTModel = YoutubeModel(id: self.id)
		
		for item in paramsYoutubeItems {
			guard let value = item.value else {
				continue
			}
			
			switch item.name {
			case "title":
				YTModel.title = value.replacingOccurrences(of: "+", with: " ")
				break
			case "keywords":
				YTModel.keywords = value.components(separatedBy: ",").map({ (d) -> String in
					return d.replacingOccurrences(of: "+", with: " ")
				})
				break
			case "player_response":
				guard
					let response = value.toJson(),
					let videoDetails = response["videoDetails"] as? [Any]
					else {
						continue
				}
				print(response)
				break
			default:
				print("> NAME --------------------------")
				print("> \(item.name)")
				print("> VALUE -------------------------")
				print("> \(value)")
				print("> -------------------------------")
				print(" ")
				break
			}
		}
		
		return YTModel
	}
}
