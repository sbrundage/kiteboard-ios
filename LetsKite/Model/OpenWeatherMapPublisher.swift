//
//  OpenWeatherMapPublisher.swift
//  LetsKite
//
//  Created by Stephen Brundage on 5/30/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import Foundation

public typealias DateForecastDictionary = [Date: [OpenWeatherMapData]]

class OpenWeatherMapPublisher: ObservableProtocol {
    typealias T = DateForecastDictionary
    
    let weatherService = OpenWeatherMapController()
    var observers: [ObserverProtocol] = []
    var city: String! {
        didSet {
            fetchWind()
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
            
            self.updateViewModel(weatherModel)
        }
    }
    
    // Convert OpenWeatherMapResponseModel to WindForecastViewModel to be consumed by TableView
    private func updateViewModel(_ model: OpenWeatherMapResponseModel) {
        let forecasts = model.list
        notifyAllObservers(with: groupForecastsByDate(forecasts))
    }
    
    private func groupForecastsByDate(_ forecasts: [OpenWeatherMapData]) -> DateForecastDictionary {
        let empty: [Date: [OpenWeatherMapData]] = [:]
        
        return forecasts.reduce(into: empty) { (dict, current) in
            let components = Calendar.current.dateComponents([.year, .month, .day], from: current.date)
            let date = Calendar.current.date(from: components)!
            let existing = dict[date] ?? []
            dict[date] = existing + [current]
        }
    }
    
    func addObserver(_ observer: ObserverProtocol) {
        observers.append(observer)
    }
    
    func removeObserver(_ observer: ObserverProtocol) {
        observers = observers.filter({ $0.id != observer.id })
    }
    
    func notifyAllObservers(with newValue: DateForecastDictionary) {
        for observer in observers {
            observer.update(with: newValue)
        }
    }
}
