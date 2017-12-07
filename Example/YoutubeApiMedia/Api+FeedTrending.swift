//
//  Api+FeedTrending.swift
//  YoutubeApiMedia_Example
//
//  Created by Jose Luis Sagredo on 6/12/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import PromiseKit

extension Api {
    func feedTrending() -> Promise<[YoutubeCoverVideo]> {
        guard let public_key = self.key else {
            return Promise(error: ApiError.unidentifier)
        }
        return self.request(
            url: Repository.v3.videos.toString(),
            method: .get,
            parameters: [
                "part" : "snippet",
                "chart" : "mostPopular",
                "regionCode" : "AR",
                "maxResults" : "25",
                "key" : public_key
            ]).then { data in
                return Promise { fulfill, reject in
                    guard
                        let params = data as? [String:Any],
                        let items = params["items"] as? [[String:Any]]
                        else {
                        reject(ApiError.unidentifier)
                        return
                    }
                    var coverList = [YoutubeCoverVideo]()
                    for item in items {
                        if let video = YoutubeCoverVideo.parse(data: item) {
                            coverList.append(video)
                        }
                    }
                    fulfill(coverList)
                }
        }
    }
    

}
