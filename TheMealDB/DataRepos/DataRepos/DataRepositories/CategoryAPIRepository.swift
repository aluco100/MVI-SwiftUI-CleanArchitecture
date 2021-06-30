//
//  CategoryAPIRepository.swift
//  DataRepos
//
//  Created by Alfredo Luco on 25-06-21.
//

import Foundation
import Combine
import DB
import Networking

class CategoryAPIRepository: CategoryGateway, ServiceInitializable {
    
    // MARK: - Public init
    
    required init() {}
    
    // MARK: - Get Categories
    
    func getCategories() -> AnyPublisher<[CategoryManagedObject], Error> {
        guard let url = try? APIClient.fetchCategories(params: nil).asURLRequest() else {
            return Just([])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .print()
            .tryMap({ element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }        
                return element.data
            })
            .map({ data in
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                let arr = json?["categories"] as? NSArray ?? []
                do {
                    return try JSONSerialization.data(withJSONObject: arr, options: .prettyPrinted)
                } catch {
                    return Data()
                }
            })
            .decode(type: [CategoryManagedObject].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}
