//
//  WindForecastViewModel.swift
//  LetsKite
//
//  Created by Stephen Brundage on 5/26/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import Foundation

class OpenWeatherMapViewModel: ObservableProtocol {
    typealias T = OpenWeatherMapResponseModel
    
    private let weatherService = OpenWeatherMapController()
    var observers: [ObserverProtocol] = []
    
    var city: String! {
        didSet {
            fetchWind()
        }
    }
    
    func addObserver(_ observer: ObserverProtocol) {
        observers.append(observer)
    }
    
    func removeObserver(_ observer: ObserverProtocol) {
        observers = observers.filter({ $0.id != observer.id })
    }
    
    func notifyAllObservers(with newValue: OpenWeatherMapResponseModel) {
        for observer in observers {
            observer.update(with: newValue)
        }
    }
    
    func fetchWind() {
        guard let city = city else { return }
        weatherService.fetchWindForecast(for: city) { (responseModel, error) in
            guard error == nil else {
                print("There was an error fetching wind. Error: \(error!)\n")
                return
            }
            
            guard let weatherModel = responseModel else {
                print("There was no error but no response model returned.\n")
                return
            }
            
            self.notifyAllObservers(with: weatherModel)
        }
    }
}
