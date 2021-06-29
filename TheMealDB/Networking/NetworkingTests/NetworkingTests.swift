//
//  NetworkingTests.swift
//  NetworkingTests
//
//  Created by Alfredo Luco on 25-06-21.
//

import XCTest
@testable import Networking
import Combine

class NetworkingTests: XCTestCase {

    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
    }
    
    // MARK: - Tear Down
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test fetch categories without params
    
    func testFetchCategoriesWithNoParams() {
        
        // Instance URL
        
        let url = try? APIClient.fetchCategories(params: nil).asURLRequest()
        
        XCTAssertNotNil(url)
        
        let promise = expectation(description: "200 OK")
        
        var subscribers = Set<AnyCancellable>()
        
        URLSession.shared
            .dataTaskPublisher(for: url!)
            .print()
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    XCTFail("BAD Response")
                    return Data()
                }
                return data
            }
            .sink(receiveCompletion: { _ in
                promise.fulfill()
            }, receiveValue: {
                print($0)
            })
            .store(in: &subscribers)
        
        wait(for: [promise], timeout: 5.0)
    }
    
    // MARK: - Test Fetch Categories with random params
    
    func testFetchCategoriesWithRandomParams() {
        // Instance URL
        
        let url = try? APIClient.fetchCategories(params: ["foo": "bar", "one": 1]).asURLRequest()
        
        XCTAssertNotNil(url)
        
        let promise = expectation(description: "200 OK")
        
        var subscribers = Set<AnyCancellable>()
        
        URLSession.shared
            .dataTaskPublisher(for: url!)
            .print()
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    XCTFail("BAD Response")
                    return Data()
                }
                return data
            }
            .sink(receiveCompletion: { _ in
                promise.fulfill()
            }, receiveValue: {
                print($0)
            })
            .store(in: &subscribers)
                
        wait(for: [promise], timeout: 5.0)
    }
    
    // MARK: - Test Fetch Categories with Params
    
    func testFetchCategoriesWithParams() {
        // Instance URL
        
        let url = try? APIClient.fetchCategories(params: ["api": "blablabla"]).asURLRequest()
        
        XCTAssertNotNil(url)
        
        let promise = expectation(description: "200 OK")
        
        var subscribers = Set<AnyCancellable>()
        
        URLSession.shared
            .dataTaskPublisher(for: url!)
            .print()
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    XCTFail("BAD Response")
                    return Data()
                }
                return data
            }
            .sink(receiveCompletion: { _ in
                promise.fulfill()
            }, receiveValue: {
                print($0)
            })
            .store(in: &subscribers)
        
        wait(for: [promise], timeout: 5.0)
    }
}
