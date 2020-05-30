//
//  CitySearchViewController.swift
//  LetsKite
//
//  Created by Stephen Brundage on 5/25/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import UIKit

class CitySearchViewController: UIViewController {

    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var findWindButton: UIButton!
    
    let weatherService = OpenWeatherMapController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
//        findWindButton.isEnabled = false
        self.navigationController?.navigationBar.barTintColor = .blue
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DisplayWindForecast" {
            if let destinationVC = segue.destination as? WindViewController {
                guard let city = cityTextField.text else { return }
//                destinationVC.openWeatherViewModel.city = city
                destinationVC.openWeatherMapPublisher.city = city
            }
        }
    }
}

// TODO: Handle city text in citytextfield
// Make sure valid
// Hide / show findWindButton depending on if there is text in textfield
