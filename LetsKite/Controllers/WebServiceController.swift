//
//  WebServiceController.swift
//  LetsKite
//
//  Created by Stephen Brundage on 5/25/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import Foundation

//public enum ServiceResult<T, U> where U: Error {
//    case success(U)
//    case failure(T)
//}

public enum WebServiceControllerError: Error {
    case invalidURL(String)
    case invalidPayload(URL)
    case unknown(Error)
    case moreInfo(String)
}

//public typealias ServiceCallback<T, U> = (ServiceResult<T, WebServiceControllerError>) -> Void

public protocol WebServiceController {
    associatedtype ResponseModel
    
    func fetchWindForecast(for city: String, completion: @escaping (ResponseModel?, WebServiceControllerError?) -> ())
}

