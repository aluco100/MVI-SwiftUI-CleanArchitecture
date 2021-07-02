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
import ViewInspector

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
    
    // MARK: - Test Category Row
    
    func testCategoryRow() throws {
        // Instance swift ui view
        
        let subject = CategoryRow(category: CategoryResult(id: "001", name: "Test name", thumbnail: "https://www.pauta.cl/pauta/site/artic/20190212/imag/foto_0000000420190212180953/pizza-3000274_960_720.jpg", description: "Test description"), viewModel: CategoryRowViewModel())
        
        // Inspect Title
        
        let title = try subject.body
            .inspect()
            .hStack(0)
            .vStack(1)
            .text(0)
            .string()
        
        XCTAssert(title == "Test name", title)
        
        // Inspect description
        
        let description = try subject.body
            .inspect()
            .hStack(0)
            .vStack(1)
            .text(1)
            .string()
        
        XCTAssert(description == "Test description", description)
        
        // load image
        
        subject.viewModel.downloadImage("https://www.pauta.cl/pauta/site/artic/20190212/imag/foto_0000000420190212180953/pizza-3000274_960_720.jpg")
        
        // Make waiter
        
        let promise = expectation(description: "Image loaded")
        
        let waiter = XCTWaiter.wait(for: [promise], timeout: 1.0)
        
        if waiter == XCTWaiter.Result.timedOut {
            
            // Inspect image
            
            let image = try subject.body
                .inspect()
                .hStack(0)
                .vStack(0)
                .image(0)
                .actualImage()
                .uiImage()
            XCTAssertTrue(image.pngData() != nil)
                
            
        }
        
    }
    
    // MARK: - Category list has right title
    
    func testCategoryList() throws {
        // Instantiate the category list view
        
        let subject = CategoryListView()
        
        // load the categories
        
        subject.presenter.fetchCategories()
        
        // Make waiter
        
        let promise = expectation(description: "200 OK")
        
        let waiter = XCTWaiter.wait(for: [promise], timeout: 1.0)
        
        if waiter == XCTWaiter.Result.timedOut {
            
            let list = try subject.body
                .inspect()
                .vStack(0)
                .navigationView(0)
                .group(0)
                .list(0)
            XCTAssertTrue(!list.isEmpty)
            
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
