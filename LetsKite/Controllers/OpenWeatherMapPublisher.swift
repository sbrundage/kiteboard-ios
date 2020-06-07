//
//  OpenWeatherMapPublisher.swift
//  LetsKite
//
//  Created by Stephen Brundage on 5/30/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import Foundation

public typealias DateForecastDictionary = [CustomDate: [OpenWeatherMapItem]]

class OpenWeatherMapPublisher: ObservableProtocol {
    typealias T = WindOutlookViewModel
    
    let weatherService = OpenWeatherMapController()
    var observers: [ObserverProtocol] = []
    
    var city: String? {
        didSet {
            fetchWind()
        }
    }
    
    func fetchWind() {
        // TODO - Validate city input
        guard let city = city else { return }
        weatherService.fetchWindForecast(for: city) { (responseModel, error) in
            guard error == nil else {
                print("There was an error fetching wind. Error: \(error!)\n")
                // TODO: Handle error
                // Display error modal, sent user back to previous screen
                return
            }
            
            guard let weatherResponseModel = responseModel else {
                print("There was no error but no response model returned.\n")
                // TODO: Handle error - This should never happen
                return
            }
            
            self.processResponseModel(weatherResponseModel)
        }
    }
    
    // Convert OpenWeatherMapResponseModel to WindForecastViewModel to be consumed by TableView
    private func processResponseModel(_ model: OpenWeatherMapResponseModel) {
        guard let groupedForecasts = groupForecastsByDate(model) else { return }
        let windOutlookViewModel = convertDictionaryToModel(groupedForecasts)
        notifyAllObservers(with: windOutlookViewModel)
    }
    
    private func convertDictionaryToModel(_ dictionary: DateForecastDictionary) -> WindOutlookViewModel {
        var dayViews = [DayViewModel]()

        for (date, weatherItems) in dictionary {
            var dayViewModel = DayViewModel(dateModel: date)
            let hourlyViews = convertToHourViewModels(weatherItems, for: date.timeZone)
            dayViewModel.hourlyViews.append(contentsOf: hourlyViews)
            dayViews.append(dayViewModel)
        }

        dayViews.sort(by: { $0.dateModel.date < $1.dateModel.date })

        return WindOutlookViewModel(dayViews: dayViews)
    }

    private func convertToHourViewModels(_ weatherItemsArray: [OpenWeatherMapItem], for timeZoneOffset: TimeInterval) -> [HourViewModel] {
        var hourlyViews: [HourViewModel] = []

        for forecast in weatherItemsArray {
            let customDate = CustomDate(unixTime: forecast.dt, timeZone: timeZoneOffset)
            hourlyViews.append(HourViewModel(
                weather: forecast.weather.first!.main,
                temp: forecast.main.temp,
                windSpeed: forecast.wind.speed, dateModel: customDate))
        }
        hourlyViews.sort(by: { $0.dateModel.date < $1.dateModel.date })
        return hourlyViews
    }
    
    private func groupForecastsByDate(_ weatherMapModel: OpenWeatherMapResponseModel) -> DateForecastDictionary? {
        let empty: DateForecastDictionary = [:]
        guard let forecasts = weatherMapModel.list else { fatalError() }
        guard let cityInfo = weatherMapModel.city else { fatalError() }
        
        return forecasts.reduce(into: empty) { (newDict, currentForecast) in
            let customDate = CustomDate(unixTime: currentForecast.dt, timeZone: cityInfo.timezone)
            guard var valuesAtKey = newDict[customDate] else {
                var newArray = Array<OpenWeatherMapItem>()
                newArray.append(currentForecast)
                newDict[customDate] = newArray
                return
            }
            valuesAtKey.append(currentForecast)
            newDict[customDate] = valuesAtKey
        }
    }
    
    func addObserver(_ observer: ObserverProtocol) {
        observers.append(observer)
    }
    
    func removeObserver(_ observer: ObserverProtocol) {
        observers = observers.filter({ $0.id != observer.id })
    }
    
    func notifyAllObservers(with newValue: T) {
        for observer in observers {
            observer.update(with: newValue)
        }
    }
}
