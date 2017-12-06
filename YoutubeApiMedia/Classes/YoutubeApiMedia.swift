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
	
	
	func parse() throws -> YoutubeMedia {
		guard let params = self.content else {
			throw errorType.withOutData
		}
		
		guard
			let paramsYoutube = URLComponents(string: "http://yt?\(params)"),
			let paramsYoutubeItems = paramsYoutube.queryItems
			else {
				throw errorType.withQueryItems
		}
		
		var sources = [Source]()
		
		let YTMedia = YoutubeMedia(id: self.id)
		var mediaType : Media.Types!
		
		for item in paramsYoutubeItems {
			guard let value = item.value else {
				continue
			}
			
			switch item.name {
			case "title":
				YTMedia.title = value.replacingOccurrences(of: "+", with: " ")
				break
			case "keywords":
				YTMedia.keywords = value.components(separatedBy: ",").map({ (d) -> String in
					return d.replacingOccurrences(of: "+", with: " ")
				})
				break
			
			case "url_encoded_fmt_stream_map":
				guard
					let components = URLComponents(string: "http://yt?\(value)"),
					let itemsComponents = components.queryItems
					else{
						continue
				}
				
				let urls = itemsComponents.filter({ (item) -> Bool in
					return item.value != nil && item.name == "url"
				})
				
				let quality = itemsComponents.filter({ (item) -> Bool in
					return (
						item.value != nil && item.name == "quality"
					)
				})
				
				if urls.count == quality.count {
					for index in 0...(urls.count - 1) {
						if let source = self.createSource(components: [quality[index],urls[index]]){
							sources.append(source)
						}
					}
				}
				mediaType = .video
				
				break

				
			case "hlsvp":
				//its alive
				mediaType = .live
				sources.append(Source(qualityType: .adaptative, url: value))
				break
			
//			case "player_response":
//				guard
//					let response = value.toJson(),
//					let videoDetails = response["videoDetails"] as? [Any]
//					else {
//						continue
//				}
//				print(response)
//				break
			default:
//				print("> NAME --------------------------")
//				print("> \(item.name)")
//				print("> VALUE -------------------------")
//				print("> \(value)")
//				print("> -------------------------------")
//				print(" ")
				break
			}
		}
		
		let media = Media(type: mediaType, source: sources)
		YTMedia.media = media
		
		return YTMedia
	}
	
	func createSource(components : [URLQueryItem]) -> Source? {
		
		var quality : Source.QualityType!
		var url : String?
		
		for component in components{
			switch component.name{
			case "quality":
				if let value = Source.QualityType(rawValue: component.value!){
					quality = value
				} else{
					quality = .adaptative
				}
				break
			case "url":
				url = component.value
				break
			default:
				break
			}
		}
		if url != nil{
			return Source(qualityType: quality, url: url!)
		}
		return nil
	}
	
	
}
