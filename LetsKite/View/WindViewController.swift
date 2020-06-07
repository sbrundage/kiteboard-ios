//
//  WindTableViewController.swift
//  LetsKite
//
//  Created by Stephen Brundage on 5/25/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import UIKit

class WindViewController: UIViewController {
    @IBOutlet weak var windForecastTableView: UITableView!
//    private(set) var openWeatherViewModel = OpenWeatherMapViewModel()
    private(set) var openWeatherMapPublisher = OpenWeatherMapPublisher()
    
    private var windViewModel: WindOutlookViewModel? {
        didSet {
            refreshTableView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        windForecastTableView.register(UINib(nibName: "DayOutlookCell", bundle: nil), forCellReuseIdentifier: "DayOutlookCell")
        windForecastTableView.estimatedRowHeight = 200
        windForecastTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setupView() {
        windForecastTableView.dataSource = self
        openWeatherMapPublisher.addObserver(self)
    }
        
    private func refreshTableView() {
        DispatchQueue.main.async {
            self.windForecastTableView.reloadData()
        }
    }
}

extension WindViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return windViewModel?.dayViews.count ?? 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayOutlookCell", for: indexPath) as! DayOutlookCell
        
        cell.dayViewModel = windViewModel?.dayViews[indexPath.row]

        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension WindViewController: ObserverProtocol {    
    var id: String {
        return "WindViewController"
    }
    
    func update<T>(with newValue: T) {
        guard let updatedModel = newValue as? WindOutlookViewModel else { return }
        self.windViewModel = updatedModel
    }
}
