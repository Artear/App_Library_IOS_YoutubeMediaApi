//
//  ContentLive.swift
//  YoutubeApiMedia_Tests
//
//  Created by Jose Luis Sagredo on 12/12/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import YoutubeApiMedia

class ContentLive: QuickSpec {
    var api:YoutubeMediaApiMock?
    var metadata:YTMetadata?
    var youtubeID = "0tek2aa8hAQ"
    
    override func spec() {
        describe("parse testing") {
            context("identifier with content media live") {
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
                
                it("is type live") {
                    expect(self.metadata!.getType()) == YTMetadata.Types.live
                }
                
                it("title is not nil") {
                    expect(self.metadata!.getTitle()).notTo(beNil())
                }
                
                it("the title is the expected") {
                    expect(self.metadata!.getTitle()) == "TN en Vivo las 24hs"
                }
                
                it("media is not nil") {
                    expect(self.metadata!.getMedia()).notTo(beNil())
                }
                
                it("media source count is one") {
                    expect(self.metadata!.getMedia()!.getSources().count) == 1
                }
              
                it("media source quality is adaptative") {
                    let quality = self.metadata!.getMedia()!.getSources().first!.getQuality()
                    expect(quality) == YTSource.QualityType.adaptative
                }
                
                it("media source url is m3u8") {
                    let url = self.metadata!.getMedia()!.getSources().first!.getURL()
                    expect(url.range(of:"index.m3u8")).notTo(beNil())
                }
                
                it("keywords count is seventeen") {
                    expect(self.metadata!.getKeyboards().count) == 17
                }
                
                it("keywords contains in text Argentina") {
                    let argentina = self.metadata!.getKeyboards().filter({ (item) -> Bool in
                        return item == "Argentina"
                    }).first
                    expect(argentina).notTo(beNil())
                }
            }
        }
    }
}
