//
//  Media.swift
//  YoutubeMediaApi
//
//  Created by Jose Luis Sagredo on 7/12/17.
//

import UIKit

public class YTMedia {
    var source = [YTSource]()
    public init(source : [YTSource]) {
        self.source = source
    }
	
	public func getSources() -> [YTSource]{
		return self.source
	}
}

