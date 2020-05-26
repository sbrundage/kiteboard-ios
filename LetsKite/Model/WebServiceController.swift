//
//  WebServiceController.swift
//  LetsKite
//
//  Created by Stephen Brundage on 5/25/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import Foundation

public enum WebServiceControllerError: Error {
    case invalidURL(String)
    case invalidPayload(URL)
    case unknown(Error)
}

public protocol WebServiceController {
    func fetchWindForecast(for city: String, completion: @escaping (String?, WebServiceControllerError?) -> ())
}
