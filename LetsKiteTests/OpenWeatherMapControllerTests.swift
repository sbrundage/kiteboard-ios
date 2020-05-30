//
//  LetsKiteTests.swift
//  LetsKiteTests
//
//  Created by Stephen Brundage on 5/25/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import XCTest
@testable import LetsKite

class OpenWeatherMapControllerTests: XCTestCase {
    
    var weatherService: OpenWeatherMapController!
    let city = "Orlando"
    
    var responseError: WebServiceControllerError?
    var responseModel: OpenWeatherMapResponseModel?

    override func setUp() {
        weatherService = OpenWeatherMapController()
    }
    
    func testResponse() {
        // Since async function, create expectation
        let expectation = self.expectation(description: "Received Response")
        
        weatherService.fetchWindForecast(for: city) { (responseModel, error) in
            self.responseError = error
            self.responseModel = responseModel
            expectation.fulfill()
        }
        
        // Wait 3 seconds for expectation to be fullfilled,
        // Otherwise timeout
        waitForExpectations(timeout: 3, handler: nil)
        
        XCTAssertNil(responseError, "No error should be returned")
        XCTAssertNotNil(responseModel, "Response Model should be successfully returned")
    }
}
