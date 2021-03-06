//
//  ContentRestrictions.swift
//  YoutubeMediaApi_Tests
//
//  Created by Jose Luis Sagredo on 12/12/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import YoutubeMediaApi

class ContentRestrictions: QuickSpec {
    var api:YoutubeMediaApiMock?
    var serverError:YoutubeMediaApiError?
    
    override func spec() {
        describe("parse testing") {
            context("identifier with content restrictions") {
                beforeEach() {
                    self.api = YoutubeMediaApiMock(id: "GmHrjFIWl6U")
                }
                
                it("server error") {
                    waitUntil { done in
                        self.api?.run().then{ metadata -> Void in
                            fail("an error was expected")
                            done()
                            }.catch { error in
                                self.serverError = error as? YoutubeMediaApiError
                                done()
                        }
                    }
                }
                
                it("server error not nil") {
                    expect(self.serverError!).notTo(beNil())
                }
                
                it("server error code is 150") {
                    expect(self.serverError!.errorCode) == 150
                }
                
            }
        }
    }
}

