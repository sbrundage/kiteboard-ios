//
//  HourView.swift
//  LetsKite
//
//  Created by Stephen Brundage on 6/7/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import UIKit

class HourView: UIView {
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    private let nibName = "HourView"
    
    convenience init() {
        self.init(frame: CGRect())
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        guard let viewFromXIB = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView else { fatalError("Could not create XIB") }
        addSubview(viewFromXIB)
        viewFromXIB.frame = bounds
        viewFromXIB.translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 8
    }
    
    internal func populate(with hourView: HourViewModel) {
        self.timeLabel.text = hourView.dateModel.dateString
        self.windSpeedLabel.text = "\(hourView.windSpeed)"
        backgroundColor = getColorFromWindSpeed(hourView.windSpeed)
        // This will show that there are cells not being cleared properly
//        backgroundColor = .clear
    }
}

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
