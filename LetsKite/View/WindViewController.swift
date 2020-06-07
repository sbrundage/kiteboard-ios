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
        windForecastTableView.delegate = self
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
//        cell.layer.cornerRadius = 5
//        cell.layer.shadowRadius = 7
//        cell.layer.shadowOpacity = 0.8
//        cell.layer.borderColor = CGColor(srgbRed: 236, green: 240, blue: 241, alpha: 1.0)
//        cell.layer.borderWidth = 20
//        cell.layer.borderColor = UIColor(red: 246, green: 240, blue: 241, alpha: 1.0)
//        cell.layer.shadowColor = CGColor(srgbRed: 236, green: 240, blue: 241, alpha: 1.0)

        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 10
//    }
}

extension WindViewController: UITableViewDelegate {

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
