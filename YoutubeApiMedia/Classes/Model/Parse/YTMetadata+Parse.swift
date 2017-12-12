//
//  YTMetadata+Decode.swift
//  Alamofire
//
//  Created by Jose Luis Sagredo on 11/12/17.
//

import UIKit

extension YTMetadata {
    public static func parse(data:String?) throws -> YTMetadata? {
        guard let stringParams = data else {
            throw YoutubeMediaApiError.withOutData
        }
        
        guard
            let urlComponent = URLComponents(string: "http://artear-youtube.com.ar?\(stringParams)"),
            let youtubeItems = urlComponent.queryItems
            else {
                throw YoutubeMediaApiError.withQueryItems
        }

        //let metadata = YTMetadata(id: self.id)
        
        if let errorCode = youtubeItems.filter({ (item) -> Bool in
            return item.value != nil && item.name == "errorcode"
        }).first {
            guard
                let errorCodeInt = Int(errorCode.value!),
                let reasonItem = youtubeItems.filter({ (item) -> Bool in
                    return item.value != nil && item.name == "reason"
                }).first,
                let reason = reasonItem.value?.decodeUrl()
                else {
                throw YoutubeMediaApiError.unknown
            }
            
            throw YoutubeMediaApiError.serverError(
                code: errorCodeInt,
                reason: reason
            )
        }
		
		
		//Video metadata keys info
		var videoId : String!
		var title : String!
		var keyboards = [String]()
		var sources = [YTSource]()
		var type : YTMetadata.Types!
		
        for item in youtubeItems {
            guard let value = item.value else {
                continue
            }
            
            switch item.name {
			case "video_id":
				videoId = value
				break
				
            case "title":
                title = value.replacingOccurrences(of: "+", with: " ")
                break
            case "keywords":
                keyboards = value.components(separatedBy: ",").map({ (d) -> String in
                    return d.replacingOccurrences(of: "+", with: " ")
                })
                break
                
            case "url_encoded_fmt_stream_map":
                let fixValue = value.replacingOccurrences(of: ",", with: "&")
                guard
                    let components = URLComponents(string: "http://yt?\(fixValue)"),
                    let itemsComponents = components.queryItems
                    else{
                        continue
                }
                
                let urls = itemsComponents.filter({ (item) -> Bool in
                    return item.value != nil && item.name == "url"
                })
                
                let qualitys = itemsComponents.filter({ (item) -> Bool in
                    return (
                        item.value != nil && item.name == "quality"
                    )
                })
				
				type = YTMetadata.Types.video
				if urls.count == 0{
					continue
				}
				
                if urls.count == qualitys.count {
                    for index in 0...(urls.count - 1) {
						if let quality = YTSource.QualityType(rawValue: qualitys[index].value!){
								sources.append(YTSource(url: urls[index].value!, qualityType: quality))
						}
                    }
                }
                
                break
            case "hlsvp":
				type = YTMetadata.Types.live
				sources.append(YTSource(url: value))
				
				break
                
                //            case "player_response":
                //                guard
                //                    let response = value.toJson(),
                //                    let videoDetails = response["videoDetails"] as? [Any]
                //                    else {
                //                        continue
                //                }
                //                print(response)
            //                break
            default:
                //                print("> NAME --------------------------")
                //                print("> \(item.name)")
                //                print("> VALUE -------------------------")
                //                print("> \(value)")
                //                print("> -------------------------------")
                //                print(" ")
                break
            }
        }
		
		if sources.count == 0 {
			throw YoutubeMediaApiError.invalidSources
		}
		
		
		let metadata = YTMetadata(id: videoId)
		metadata.keywords = keyboards
		metadata.title = title
		metadata.type = type
		metadata.media = YTMedia(source: sources)
		
		return metadata
//        let media = Youtube.Metadata.Media(source: sources)
//        Metadata.media = media
//        return Metadata
//
//        return nil
    }
}
