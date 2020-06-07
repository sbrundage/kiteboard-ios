//
//  HourlyStackView.swift
//  LetsKite
//
//  Created by Stephen Brundage on 6/7/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import UIKit

class HourlyStackView: UIStackView {
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var hourlyViews: [HourViewModel]? {
        didSet {
            populateStackView()
            setupConstraints()
        }
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupStackView()
    }
    
    private func setupStackView() {
        distribution = .fillEqually
        backgroundColor = .clear
    }
    
    private func populateStackView() {
        guard let hourlyViewModel = hourlyViews else {
            print("hourly view model is nil")
            return
        }
        
        hourlyViewModel.forEach { hourViewModel in
            let hourlyView = HourView()
            hourlyView.populate(with: hourViewModel)
            addArrangedSubview(hourlyView)
        }
    }
    
    private func calculateHeight() -> CGFloat {
        return CGFloat((hourlyViews?.count ?? 0) * 85)
    }
    
    private func setupConstraints() {
        heightConstraint.constant = calculateHeight()
    }
}
