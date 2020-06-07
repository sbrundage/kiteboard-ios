//
//  DayOutlookCell.swift
//  LetsKite
//
//  Created by Stephen Brundage on 6/6/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import UIKit

class DayOutlookCell: UITableViewCell {
    
    @IBOutlet weak var hourlyOutlookStackView: HourlyStackView!
    
    var dayViewModel: DayViewModel? {
        didSet {
            setupStackView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setupStackView() {
        guard let viewModel = dayViewModel else { return }
        hourlyOutlookStackView.hourlyViews = viewModel.hourlyViews
    }
    
    private func removeAllSubviews() {
        hourlyOutlookStackView.subviews.forEach {
            hourlyOutlookStackView.removeArrangedSubview($0)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10))
    }
    
    override func prepareForReuse() {
        removeAllSubviews()
        dayViewModel = nil
    }
}
