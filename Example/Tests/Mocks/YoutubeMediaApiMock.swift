//
//  YoutubeMediaApiMock.swift
//  YoutubeApiMedia_Tests
//
//  Created by Jose Luis Sagredo on 11/12/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import PromiseKit
import YoutubeApiMedia

public class YoutubeMediaApiMock {
    var id:String
    public init(id:String) {
        self.id = id
    }

    public func run() -> Promise<YTMetadata> {
        return Promise { fulfill, reject in
            guard
                let fileURL = Bundle(for: type(of: self)).url(forResource: self.id, withExtension: "txt") else {
                reject(YoutubeMediaApiError.unknown)
                return
            }
            let data = try String(contentsOf: fileURL, encoding: String.Encoding.utf8)
                .trimmingCharacters(in: .whitespacesAndNewlines)
            
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
