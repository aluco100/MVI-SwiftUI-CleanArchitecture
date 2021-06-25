//
//  CategoryGateway.swift
//  DataRepos
//
//  Created by Alfredo Luco on 25-06-21.
//

import Foundation
import Combine
import DB

public protocol CategoryGateway: AnyObject {
    // Get Categories
    
    func getCategories() -> AnyPublisher<[CategoryManagedObject], Error>
}
