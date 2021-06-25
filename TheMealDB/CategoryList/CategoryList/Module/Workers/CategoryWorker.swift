//
//  CategoryWorker.swift
//  CategoryList
//
//  Created by Alfredo Luco on 25-06-21.
//

import Foundation
import DataRepos

class CategoryWorker: FetchCategories {
    
    // MARK: - Use Cases
    
    var categoryGateway: CategoryGateway
    
    // MARK: - Dependency Injection
    
    init(_ repo: CategoryGateway) {
        categoryGateway = repo
    }
    
}
