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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cityTextField.delegate = self
    }
    
    @IBAction func findWindButtonClicked(_ sender: Any) {
        if let city = cityTextField.text {
            
        }
    }
    
    private func setupView() {
        cityTextField.delegate = self
        findWindButton.isEnabled = false
    }
}

extension CitySearchViewController: UITextFieldDelegate {
    // Handle user input
    // disable / enable button depending on input text
}
