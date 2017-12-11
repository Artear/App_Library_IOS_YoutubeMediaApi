//
//  YoutubeApiMedia.swift
//  Nimble
//
//  Created by Mauro Gonzalez on 05/12/2017.
//

import Foundation
import PromiseKit

public class YoutubeMediaApi {
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
            .alamofireLog()
            .responseString().then { data in
                return Promise { fulfill, reject in
                    do {
                        if let metadata = try YTMetadata.parse(data: data) {
                            fulfill(metadata)
                        }
                        reject(YoutubeMediaApiError.unknown)
                    } catch {
                        reject(error)
                    }
                }
        }
    }
	
}

extension DataRequest {
    public func alamofireLog() -> Self {
        print("Request: \(self)")
        return self
    }
}
