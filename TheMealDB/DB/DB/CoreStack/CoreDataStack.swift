//
//  CoreDataStack.swift
//  DB
//
//  Created by Alfredo Luco on 24-06-21.
//

import Foundation
import CoreData

public class CoreDataStack {
    // MARK: - View Context
    
    static public var viewContext: NSManagedObjectContext = {
       
        let bundle = Bundle(for: CoreDataStack.self)
        guard let modelURL = bundle.url(forResource: "TheMealDB", withExtension: ".momd"),
              let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("there's no model version")
        }
        
        let container = NSPersistentContainer(name: "TheMealDB", managedObjectModel: model)
        
        container.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("\(#file), \(#function), \(error!.localizedDescription)")
            }
        }
        
        return container.viewContext
    }()
    
    // MARK: - Save
    
    static public func save() {
        guard viewContext.hasChanges else { return }
        
        do {
            try viewContext.save()
        } catch let error {
            print(error)
        }
    }
}
