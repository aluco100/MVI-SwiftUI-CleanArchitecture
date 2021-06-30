//
//  ServiceLocatorProtocol.swift
//  DataRepos
//
//  Created by Alfredo Luco on 30-06-21.
//

import Foundation

public protocol ServiceInitializable: AnyObject {
    init()
}

protocol ServiceLocatorProtocol: AnyObject {
    
    // Cache
    
    var services: [String: Any] {get set}
    
    
    // Get service
    
    func getService<S: ServiceInitializable>() -> S
    
    // Add Service
    
    func register<S: AnyObject>(service: S)
}
