//
//  CategoryCoreDataRepository.swift
//  DataRepos
//
//  Created by Alfredo Luco on 25-06-21.
//

import Foundation
import Combine
import DB
import CoreData

class CategoryCoreDataRepository: CategoryGateway, ServiceInitializable {
    
    // MARK: - Public init
    
    required init() { }
    
    // MARK: - Get Categories
    
    func getCategories() -> AnyPublisher<[CategoryManagedObject], Error> {
        Future<[CategoryManagedObject], Error> { promise in
            let context = CoreDataStack.viewContext
            
            let fetchRequest = NSFetchRequest<CategoryManagedObject>(entityName: "CategoryManagedObject")
            
            do {
                
                let categories = try context.fetch(fetchRequest)
                
                promise(.success(categories))
                
            } catch let error {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
}
