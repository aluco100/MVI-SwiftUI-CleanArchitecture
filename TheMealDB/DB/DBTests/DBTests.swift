//
//  DBTests.swift
//  DBTests
//
//  Created by Alfredo Luco on 24-06-21.
//

import XCTest
@testable import DB
import CoreData

class DBTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test Check View Context exist
    
    func testViewContextExists() {
        let context = CoreDataStack.viewContext
        XCTAssertNotNil(context)
    }
    
    // MARK: - Test Save Object To DB
    
    func testSaveObjectToDB() {
        
        // Init the context
        
        let context = CoreDataStack.viewContext
        
        // Instance an empty object
        
        let entityDescription = NSEntityDescription.entity(forEntityName: String(describing: CategoryManagedObject.self), in: context)
        
        XCTAssertNotNil(entityDescription)
        
        let mock = CategoryManagedObject(entity: entityDescription!, insertInto: context)
        
        XCTAssertNotNil(mock.managedObjectContext)
        
        // Check if it needs to save
        
        XCTAssertTrue(context.hasChanges)
        
        // Save Into DB
        
        CoreDataStack.save()
        
    }
    
    // MARK: - Decode Category with bad json
    
    func testDecodeCategoryWithBadJSON() {

        // Instance a bad json
        
        let badJSON: [String: Any] = [
            "id": 1,
            "idCategory": -1001,
            "strCategory": "caca",
            "strCategoryDescription": NSNull.init(),
            "strCategoryThumb": 12345
        ]
        
        // Perform decode
        
        _ = DBDecoder.decode(with: badJSON, classType: CategoryManagedObject.self)
        
    }
    
    // MARK: - Decode Category
    
    func testDecodeCategory() {
        
        // Instance good json
        
        let goodJSON: [String: Any] = [
            "idCategory": "001",
            "strCategory": "Breads",
            "strCategoryDescription": "lorem ipsum",
            "strCategoryThumb": ""
        ]
        
        // Perform decode
        
        _ = DBDecoder.decode(with: goodJSON, classType: CategoryManagedObject.self)
        
    }
    
    // MARK: - Test Need to save to context
    
    func testNeedToSaveToContext() {
        // Instance good json
        
        let goodJSON: [String: Any] = [
            "idCategory": "001",
            "strCategory": "Breads",
            "strCategoryDescription": "lorem ipsum",
            "strCategoryThumb": ""
        ]
        
        // Perform decode
        
        let decoded = DBDecoder.decode(with: goodJSON, classType: CategoryManagedObject.self)
        
        // View Context
        
        let context = CoreDataStack.viewContext
        
        context.insert(decoded)
        
        XCTAssertTrue(context.hasChanges)
        
    }
    
    // MARK: - Test Don't need to save to context
    
    func testDontNeedToSaveToContext() {
        // Instance good json
        
        let goodJSON: [String: Any] = [
            "idCategory": "001",
            "strCategory": "Breads",
            "strCategoryDescription": "lorem ipsum",
            "strCategoryThumb": ""
        ]
        
        // Perform decode
        
        _ = DBDecoder.decode(with: goodJSON, classType: CategoryManagedObject.self)
        
        // Check if there's no changes to save
        
        XCTAssertTrue(CoreDataStack.viewContext.hasChanges == false)
    }
    
    
    // MARK: - Struct to perform decodable protocol
    
    struct DBDecoder {
        static func decode<T>(with dict: [String: Any], classType: T.Type) -> T where T: Decodable {
            // Encode data
            
            let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            
            XCTAssertNotNil(jsonData)
            
            // Decode JSON
            
            let jsonDecoder = JSONDecoder()
            
            // Decode
            
            let decoded = try? jsonDecoder.decode(classType, from: jsonData!)
            
            XCTAssertNotNil(decoded)
            
            // Check if there's nothing to save
            
            XCTAssertTrue(CoreDataStack.viewContext.hasChanges == false)
            
            return decoded!
        }
    }

}
