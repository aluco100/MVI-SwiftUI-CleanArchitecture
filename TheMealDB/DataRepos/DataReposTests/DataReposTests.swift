//
//  DataReposTests.swift
//  DataReposTests
//
//  Created by Alfredo Luco on 25-06-21.
//

import XCTest
@testable import DataRepos
import Combine

class DataReposTests: XCTestCase {
    
    fileprivate var subscriptors: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        self.subscriptors = []
    }
    
    // MARK: - Test fetch categories from api
    
    func testCategoriesAPI() {
        self.performFetchData(CategoryAPIRepository())
    }
    
    // MARK: - Test Fetch categories from Core Data
    
    func testCategoriesCoreData() {
        self.performFetchData(CategoryCoreDataRepository())
    }
    
    // MARK: - Register Category API Repo
    
    func testRegisterCategoryAPIRepo() {
        // Instance service Locator
        
        let serviceLocator = CategoryServiceLocator()
        
        // Get api repo from locator
        
        let categoryRepo: CategoryAPIRepository = serviceLocator.getService()
        
        // Be sure if there's in locator cache
        
        XCTAssertTrue(serviceLocator.services[String(describing: categoryRepo.self)] != nil)
    }
    
    // MARK: - Register Category Core Data Repo
    
    func testRegisterCategoryCoreDataRepo() {
        // Instance service Locator
        
        let serviceLocator = CategoryServiceLocator()
        
        // Get api repo from locator
        
        let categoryRepo: CategoryCoreDataRepository = serviceLocator.getService()
        
        // Be sure if there's in locator cache
        
        XCTAssertTrue(serviceLocator.services[String(describing: categoryRepo.self)] != nil)
    }
    
    // MARK: - Perform fetch data
    
    func performFetchData(_ categoryRepo: CategoryGateway) {
        // Make a expectation
        let promise = expectation(description: "200 OK")
        
        // Instance api category repository
        
        categoryRepo
            .getCategories()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                promise.fulfill()
            } receiveValue: { value in
                print(value)
            }
            .store(in: &subscriptors)
        
        // wait for expectations
        
        wait(for: [promise], timeout: 5.0)
    }

}
