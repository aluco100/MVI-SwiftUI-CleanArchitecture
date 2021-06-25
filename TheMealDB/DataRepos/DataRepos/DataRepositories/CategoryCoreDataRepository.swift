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

public class CategoryCoreDataRepository: CategoryGateway {
    
    // MARK: - Public init
    
    public init() { }
    
    // MARK: - Get Categories
    
    public func getCategories() -> AnyPublisher<[CategoryManagedObject], Error> {
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
