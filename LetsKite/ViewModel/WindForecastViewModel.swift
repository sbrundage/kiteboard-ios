//
//  WindForecastViewModel.swift
//  LetsKite
//
//  Created by Stephen Brundage on 5/26/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import Foundation

class OpenWeatherMapWindForecastViewModel: ObservableProtocol {
    typealias T = OpenWeatherMapResponseModel
    var value: OpenWeatherMapResponseModel
    
    var observers: [ObserverProtocol] = []
    
    init(responseModel: OpenWeatherMapResponseModel) {
        self.value = responseModel
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
}
