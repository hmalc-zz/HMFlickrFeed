//
//  HMFlickrTests.swift
//  HMFlickrTests
//
//  Created by Hayden Malcomson on 2018-07-12.
//  Copyright © 2018 Hayden Malcomson. All rights reserved.
//

import XCTest
@testable import HMFlickr

class HMFlickrTests: XCTestCase {
    
    var data: Data?
    
    override func setUp() {
        super.setUp()
        do {
            if let file = Bundle.main.url(forResource: "ExampleOutput", withExtension: "json") {
                let data = try Data(contentsOf: file)
                self.data = data
            } else {
                throw FlickrAPIError.invalidMockFile
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    override func tearDown() {
        super.tearDown()
        self.data = nil
    }
    
    func testJSONDecode(){
        let jsonDecoder = JSONDecoder()
        do {
            let _ = try jsonDecoder.decode(FlickrPublicFeed.self,from: self.data!)
            XCTAssert(true)
        } catch let error {
            XCTAssert(false, error.localizedDescription)
        }
    }
    
    func testUserDecodedName(){
        let jsonDecoder = JSONDecoder()
        do {
            let feed = try jsonDecoder.decode(FlickrPublicFeed.self,from: self.data!)
            XCTAssertEqual(feed.items!.first!.extractedAuthorUserName!, "Tomashenski")
        } catch let error {
            XCTAssert(false, error.localizedDescription)
        }
    }
    

    
}
