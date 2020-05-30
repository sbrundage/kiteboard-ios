//
//  Date+ModifyComponents.swift
//  LetsKite
//
//  Created by Stephen Brundage on 5/30/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import Foundation

public enum DateModifier {
    case increment
    case decrement
}

public enum DateComponentUnit {
    case hour
    case day
}

public extension Date {
    func modifyDate(_ modifier: DateModifier, _ unit: DateComponentUnit, by num: Int) -> Date? {
        var dateComponent = DateComponents()
        
        switch unit {
        case .hour:
            dateComponent.hour = modifier == .increment ? num : -num
        case .day:
            dateComponent.day = modifier == .increment ? num : -num
        }
        return Calendar.current.date(byAdding: dateComponent, to: self)
    }
}
