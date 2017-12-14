//
//  YoutubeCoverVideo.swift
//  YoutubeMediaApi_Example
//
//  Created by Jose Luis Sagredo on 6/12/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class YoutubeCoverVideo {
    let id:String
    let title:String
    let description:String
    
    let channelId:String
    let channelTitle:String
    
    init(
        id:String,
        title:String,
        description:String,
        channelId:String,
        channelTitle:String
        )
    {
        self.id = id
        self.title = title
        self.description = description
        
        self.channelId = channelId
        self.channelTitle = channelTitle
    }
    
    
    static func parse(data:[String:Any]) -> YoutubeCoverVideo? {
        guard
            let id = data["id"] as? String,
            let snippet = data["snippet"] as? [String:Any],
            let title = snippet["title"] as? String,
            let description = snippet["description"] as? String,
            let channelId = snippet["channelId"] as? String,
            let channelTitle = snippet["channelTitle"] as? String
            else {
                return nil
        }

        return YoutubeCoverVideo(
            id: id,
            title: title,
            description: description,
            channelId: channelId,
            channelTitle: channelTitle
        )
    }
}
