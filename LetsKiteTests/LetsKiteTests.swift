//
//  LetsKiteTests.swift
//  LetsKiteTests
//
//  Created by Stephen Brundage on 5/25/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import XCTest
@testable import LetsKite

class LetsKiteTests: XCTestCase {
    
    var weatherService: OpenWeatherMapController!

    override func setUp() {
        weatherService = OpenWeatherMapController()
    }
    
    func testResponse() {
        weatherService.fetchWindForecast(for: "orlando") { (responseString, webServiceError) in
            XCTAssertNotNil(webServiceError)
            print("Response String: \(responseString)")
        }
    }
}
