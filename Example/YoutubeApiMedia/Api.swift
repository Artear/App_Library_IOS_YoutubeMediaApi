//
//  Api.swift
//  YoutubeApiMedia_Example
//
//  Created by Jose Luis Sagredo on 6/12/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import PromiseKit

public class Api {
    public static let shared = Api()
    internal var key:String?
    
    private init() {}
    public func identifier(key:String) {
        self.key = key
    }
    
    public func request(
        url:String,
        method:HTTPMethod = .get,
        parameters:Parameters = [:]
        ) -> Promise<Any>
    {
        
        let headers: HTTPHeaders = [
            "User-Agent": "Mozilla/5.0"
        ]
        
        return Alamofire.request(url,
                                 method: method,
                                 parameters: parameters,
                                 encoding: URLEncoding.default,
                                 headers: headers
            )
            .validate()
            .log()
            .responseJSON()
    }
}

extension DataRequest {
    public func log() -> Self {
        print("Request: \(self)")
        return self
    }
}
