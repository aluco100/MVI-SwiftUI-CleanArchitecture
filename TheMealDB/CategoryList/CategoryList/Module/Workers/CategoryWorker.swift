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
    fileprivate var serviceLocator: CategoryServiceLocator = CategoryServiceLocator()
    
    // MARK: - Dependency Injection
    
    init(with cache: Bool) {
        if cache {
            let repo: CategoryCoreDataRepository = serviceLocator.getService()
            categoryGateway = repo
        }else {
            let repo: CategoryAPIRepository = serviceLocator.getService()
            categoryGateway = repo
        }
    }
    
}
