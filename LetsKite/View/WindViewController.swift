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
    private(set) var openWeatherViewModel = OpenWeatherMapViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        windForecastTableView.delegate = self
    //        windForecastTableView.dataSource = self
        openWeatherViewModel.addObserver(self)
    }
}

extension WindViewController: UITableViewDelegate {
    
}

extension WindViewController: ObserverProtocol {
    var id: String {
        return "WindViewController"
    }
    
    func update<T>(with newValue: T) {
        print("Got a new value of: \(newValue)")
    }
}

//extension WindViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    }
//}
