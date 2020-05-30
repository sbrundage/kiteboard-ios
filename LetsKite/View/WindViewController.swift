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
    
    private var forecastDictionary: DateForecastDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        windForecastTableView.delegate = self
        openWeatherMapPublisher.addObserver(self)
        windForecastTableView.dataSource = self
    }
}

extension WindViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayCell", for: indexPath)
        
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return forecastDictionary?.count ?? 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
}

extension WindViewController: UITableViewDelegate {

}

extension WindViewController: ObserverProtocol {
    var id: String {
        return "WindViewController"
    }
    
    func update<T>(with newValue: T) {
        if let updatedValue = newValue as? DateForecastDictionary {
            forecastDictionary = updatedValue
        }
    }
}
