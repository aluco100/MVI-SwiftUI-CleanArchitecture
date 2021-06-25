//
//  CategoryManagedObject.swift
//  DB
//
//  Created by Alfredo Luco on 25-06-21.
//

import Foundation
import CoreData

public class CategoryManagedObject: NSManagedObject, Decodable {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case idCategory
        case strCategory
        case strCategoryDescription
        case strCategoryThumb
    }
    
    
    // MARK: - Decodable implementation
    
    required public convenience init(from decoder: Decoder) throws {
        
        // Init
        let context = CoreDataStack.viewContext
        print(context)
        guard let entity = NSEntityDescription.entity(forEntityName: String(describing: Self.self), in: context) else {
            throw NSError(domain: "TheMealDB", code: 400, userInfo: [NSLocalizedDescriptionKey: "no context fetched"])
        }
        
        self.init(entity: entity, insertInto: nil)
        
        // Mapping
        
        // Get The Container
        
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Mapping Some Properties
        
        self.idCategory = try container.decodeIfPresent(String.self, forKey: .idCategory)
        self.strCategory = try container.decodeIfPresent(String.self, forKey: .strCategory)
        self.strCategoryDescription = try container.decodeIfPresent(String.self, forKey: .strCategoryDescription)
        self.strCategoryThumb = try container.decodeIfPresent(String.self, forKey: .strCategoryThumb)
    }
}
