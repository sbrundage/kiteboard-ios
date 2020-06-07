//
//  TimeIntervalToDateConverterTest.swift
//  LetsKiteTests
//
//  Created by Stephen Brundage on 6/4/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import XCTest

class TimeIntervalToDateConverterTest: XCTestCase {
    
    var dateFormatter = DateFormatter()
    var timeInterval: Double!
    var date: Date!
    var expectedDateString = "Jun 4, 2020 at 2:00:00 PM"

    override func setUp() {
        timeInterval = 1591293600
        
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .medium
        dateFormatter.timeZone = TimeZone(abbreviation: "EST")
        
        date = Date(timeIntervalSince1970: timeInterval)
    }
    
    func testDateConverter() {
        let dateString = dateFormatter.string(from: date)
        XCTAssertEqual(dateString, expectedDateString)
    }
}
