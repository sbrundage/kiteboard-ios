//
//  ObserverDesignPattern.swift
//  LetsKite
//
//  Created by Stephen Brundage on 5/26/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import Foundation

protocol ObserverProtocol {
    var id: String { get }
    func update<T>(with newValue: T)
}

protocol ObservableProtocol {
    associatedtype T
    var observers: [ObserverProtocol] { get }
    
    func addObserver(_ observer: ObserverProtocol)
    func removeObserver(_ observer: ObserverProtocol)
    func notifyAllObservers(with newValue: T)
}
