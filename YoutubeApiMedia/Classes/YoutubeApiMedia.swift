//
//  YoutubeApiMedia.swift
//  Nimble
//
//  Created by Mauro Gonzalez on 05/12/2017.
//

import Foundation
import PromiseKit

public class YoutubeMediaApi {
	enum errorType: Error {
		case unknown
		case withOutData
		case withQueryItems
		case outsideBroadcast
		case notHls
	}
	var id:String
	public init(id:String) {
		self.id = id
	}
    // TODO: Rename ?
    public func run() -> Promise<YTMetadata> {
        let headers: HTTPHeaders = [
            "User-Agent": "Mozilla/5.0"
        ]
        
        return Alamofire.request(
            "https://www.youtube.com/get_video_info",
            method: .get,
            parameters: ["video_id": self.id],
            encoding: URLEncoding.default,
            headers: headers
            )
            .validate()
            .responseString().then { data in
                return Promise { fulfill, reject in
                    // TODO: add parse
                    fulfill(YTMetadata(id: self.id))
                }
        }
    }
	
}


