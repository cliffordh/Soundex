//
//  SoundexTests.swift
//  SoundexTests
//
//  Created by Sergiy Iastremskyi on 8/29/16.
//  Copyright © 2016 Hotwire. All rights reserved.
//

import XCTest
@testable import Soundex

class SoundexTests: XCTestCase {
    
    func testSoundex() {
        
        XCTAssertEqual(Soundex().soundex("Robert"), "R163")
        XCTAssertEqual(Soundex().soundex("Rupert"), "R163")
        XCTAssertEqual(Soundex().soundex("Rubin"), "R150")
        XCTAssertEqual(Soundex().soundex("Ashcraft"), "A261")
        XCTAssertEqual(Soundex().soundex("Ashcroft"), "A261")
        XCTAssertEqual(Soundex().soundex("Tymczak"), "T522")
        XCTAssertEqual(Soundex().soundex("Pfister"), "P236")
    }
}
