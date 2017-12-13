//
//  ViewControllerPresenter.swift
//  YoutubeApiMedia_Example
//
//  Created by Jose Luis Sagredo on 6/12/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import PromiseKit

class ViewControllerPresenter: NSObject {
    var idsYoutube = [YoutubeCoverVideo]()
    
    func loadData() -> Promise<Bool> {
        return Promise { fulfill, reject in
            Api.shared.feedTrending().then { items -> Void in
                self.idsYoutube.append(contentsOf: items)
                fulfill(true)
                }.catch { error in
                    reject(error)
            }
        }
    }
}
