//
//  UIView+WindSpeedColor.swift
//  LetsKite
//
//  Created by Stephen Brundage on 6/7/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import UIKit

extension UIView {
    public func getColorFromWindSpeed(_ windSpeed: Float) -> UIColor {
        switch windSpeed {
        case _ where windSpeed <= 12:
            return .green
        case _ where windSpeed <= 20:
            return .orange
        case _ where windSpeed <= 30:
            return .red
        default:
            return .purple
        }
    }
}
