//
//  CategoryServiceLocator.swift
//  DataRepos
//
//  Created by Alfredo Luco on 30-06-21.
//

import Foundation

public class CategoryServiceLocator: ServiceLocatorProtocol {
    
    // MARK: - Cache
    
    var services: [String: Any] = [:]
    
    // MARK: - Get Service
    
    
    public func getService<S: ServiceInitializable>() -> S {
        if services[String(describing: S.self)] != nil {
            return services[String(describing: S.self)] as! S
        }
        let service = S.init()
        self.register(service: service)
        return service
    }
    
    
    // MARK: - Register
    
    func register<S: AnyObject>(service: S) {
        self.services[String(describing: service.self)] = service
    }
    
    
}
