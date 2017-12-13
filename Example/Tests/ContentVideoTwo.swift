//
//  ContentVideoTwo.swift
//  YoutubeApiMedia_Tests
//
//  Created by Jose Luis Sagredo on 12/12/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Quick
import Nimble
import YoutubeApiMedia

class ContentVideoTwo: QuickSpec {
    var api:YoutubeMediaApiMock?
    var metadata:YTMetadata?
    var youtubeID = "sTiKv0rK9OE"
    
    override func spec() {
        describe("parse testing") {
            
            context("identifier with content media video") {
                beforeEach() {
                    self.api = YoutubeMediaApiMock(id: self.youtubeID)
                }
                
                it("create metadata") {
                    waitUntil { done in
                        self.api?.run().then{ metadata -> Void in
                            self.metadata = metadata
                            done()
                            }.catch { error in
                                fail("an error was expected")
                                done()
                        }
                    }
                }
                
                it("not nil") {
                    expect(self.metadata!).notTo(beNil())
                }
                
                it("id is \(self.youtubeID)") {
                    expect(self.metadata!.getId()) == self.youtubeID
                }
                
                it("is type video") {
                    expect(self.metadata!.getType()) == YTMetadata.Types.video
                }
                
                it("title is not nil") {
                    expect(self.metadata!.getTitle()).notTo(beNil())
                }
                
                it("the title is the expected") {
                    let title = "Rosario Central vs Newell's -(1-0)- RESUMEN EXTENDIDO - Superliga 2017 - HD"
                    expect(self.metadata!.getTitle()!) == title
                }
                
                it("media is not nil") {
                    expect(self.metadata!.getMedia()).notTo(beNil())
                }
                
                it("media source count is five") {
                    expect(self.metadata!.getMedia()!.getSources().count) == 5
                }
                
                it("media source urls") {
                    let url = self.metadata!.getMedia()!.getSources().filter({ (item) -> Bool in
                        return (item.getURL().range(of:"videoplayback") != nil)
                    })
                    expect(url.count) == 5
                }
                
                it("keywords count is seventeen") {
                    expect(self.metadata!.getKeyboards().count) == 11
                }
                
            }
        }
    }
}

