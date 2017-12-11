//
//  YTMetadata+Decode.swift
//  Alamofire
//
//  Created by Jose Luis Sagredo on 11/12/17.
//

import UIKit

extension YTMetadata {
    static func parse(data:String?) throws -> YTMetadata? {
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
        
        for item in youtubeItems {
            guard let value = item.value else {
                continue
            }
            
            switch item.name {
            case "title":
//                Metadata.title = value.replacingOccurrences(of: "+", with: " ")
                break
            case "keywords":
//                Metadata.keywords = value.components(separatedBy: ",").map({ (d) -> String in
//                    return d.replacingOccurrences(of: "+", with: " ")
//                })
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
//                        if let source = self.createSource(components: [quality[index],urls[index]]){
//                            sources.append(source)
//                        }
                    }
                }
                
                break
            case "hlsvp":
//                Metadata.type = .live
//                sources.append(Youtube.Metadata.Media.Sourse(url: value))
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
        
//        let media = Youtube.Metadata.Media(source: sources)
//        Metadata.media = media
//        return Metadata

        
        return nil
    }
}
