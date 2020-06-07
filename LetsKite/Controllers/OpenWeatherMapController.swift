//
//  OpenWeatherMapController.swift
//  LetsKite
//
//  Created by Stephen Brundage on 5/25/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import Foundation

class OpenWeatherMapController: WebServiceController {
    
    typealias ResponseModel = OpenWeatherMapResponseModel
    
    func fetchWindForecast(for city: String, completion: @escaping (ResponseModel?, WebServiceControllerError?) -> ()) {
        let endpoint = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&units=imperial&appid=\(APIKey.openWeather.rawValue)"

        guard let safeURLString = endpoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let endpointURL = URL(string: safeURLString) else {
                completion(nil, .invalidURL(endpoint))
                return
        }

        let dataTask = URLSession.shared.dataTask(with: endpointURL) { (data, response, error) in
            guard error == nil else {
                completion(nil, .unknown(error!))
                return
            }

            guard let responseData = data else {
                completion(nil, .invalidPayload(endpointURL))
                return
            }

            let decoder = JSONDecoder()
            do {
                let weatherModel = try decoder.decode(ResponseModel.self, from: responseData)
                completion(weatherModel, nil)
            } catch let error {
                completion(nil, .unknown(error))
            }
        }
        dataTask.resume()
    }
}
