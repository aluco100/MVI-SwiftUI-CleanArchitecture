//
//  CategoryListTests.swift
//  CategoryListTests
//
//  Created by Alfredo Luco on 25-06-21.
//

import XCTest
@testable import CategoryList
import Combine
import DataRepos

class CategoryListTests: XCTestCase {

    // MARK: - Properties
    
    var subscriptors: Set<AnyCancellable>!
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        subscriptors = []
    }
    
    // MARK: - Check if the service is core data
    
    func testCheckCoreDataServiceCheck() {
        // Instance worker
        let worker = CategoryWorker(with: true)
        
        // Check if the gateway is core data
        
        XCTAssertTrue(worker.categoryGateway is CategoryCoreDataRepository)
        
        // Check if the service is in locator
        
        XCTAssertTrue(worker.serviceLocator.services[String(reflecting: CategoryCoreDataRepository.self)] != nil)
    }
    
    // MARK: - Check if the service is api
    
    func testCheckAPIServiceCheck() {
        // Instance worker
        let worker = CategoryWorker(with: false)
        
        // Check if the gateway is core data
        
        XCTAssertTrue(worker.categoryGateway is CategoryAPIRepository)
        
        // Check if the service is in locator
        
        XCTAssertTrue(worker.serviceLocator.services[String(reflecting: CategoryAPIRepository.self)] != nil)
    }
    
    // MARK: - Fetch Categories from use case
    
    func testFetchCategoriesFromUseCase() {
        // Make expectation
        
        let promise = expectation(description: "200 OK")
        
        // Instance worker
        
        let worker = CategoryWorker(with: false)
        
        // Fetch
        
        worker
            .getCategories()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                    break
                case .finished:
                    break
                }
                promise.fulfill()
            } receiveValue: { value in
                print(value)
            }
            .store(in: &subscriptors)
        
        // Wait
        
        wait(for: [promise], timeout: 5.0)

    }

    
    // MARK: - Check fetch categories with state
    
    func testCheckFetchCategoriesWithState() {
        // Make expectation
        
        let promise = expectation(description: "200 OK")
        
        // Instance presenter
        
        let presenter = CategoryListPresenter()
        
        // Fetch Categories
        
        presenter.fetchCategories()
        
        // Make waiter
        
        let waiter = XCTWaiter.wait(for: [promise], timeout: 1.0)
        
        if waiter == XCTWaiter.Result.timedOut {
            
            // Check variables
            
            XCTAssertTrue(presenter.isLoading == false)
            XCTAssertTrue(!presenter.categories.isEmpty)
            XCTAssert(presenter.hasError == false)
            XCTAssert(presenter.errorMessage.isEmpty)
            
        }
    }
    
    // MARK: - Download Image
    
    func testDownloadImage() {
        // Make expectation
        
        let promise = expectation(description: "200 OK")
        
        // Instance View Model from row
        
        let viewModel = CategoryRowViewModel()
        
        viewModel.downloadImage("https://www.pauta.cl/pauta/site/artic/20190212/imag/foto_0000000420190212180953/pizza-3000274_960_720.jpg")
        
        // waiter
        
        let waiter = XCTWaiter.wait(for: [promise], timeout: 1.0)
        
        if waiter == XCTWaiter.Result.timedOut {
            
            // Check Variables
            
            XCTAssertTrue(!viewModel.imageData.isEmpty)
            
        }
    }
    
    // MARK: - Check Category List
    
    func testCheckCategoryList() {
        // Make expectation
        
        let promise = expectation(description: "200 OK")
        
        // Instance Component
        
        let list = CategoryListView()
        
        list.presenter.fetchCategories()
        
        // Waiter
        
        let waiter = XCTWaiter.wait(for: [promise], timeout: 1.0)
        
        if waiter == XCTWaiter.Result.timedOut {
            
            // Check
            
            XCTAssertTrue(!list.presenter.categories.isEmpty)
            
        }
    }
}
