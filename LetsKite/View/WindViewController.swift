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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        windForecastTableView.delegate = self
//        windForecastTableView.dataSource = self
    }
}

extension WindViewController: UITableViewDelegate {
    
}

//extension WindViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    }
//}
