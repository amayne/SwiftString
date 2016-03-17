//
//  SwiftStringTests.swift
//  SwiftStringTests
//
//  Created by Andrés Catalán on 2016–03–16.
//  Copyright © 2016 Ayre. All rights reserved.
//

import XCTest
@testable import SwiftString

class SwiftStringHTMLTests: XCTestCase {
    
    func testDecodeHTML() {
        XCTAssertEqual("e&ntilde;e".decodeHTML(), "eñe", "\"eñe\".decodeHTML() passed")
    }
    
}
