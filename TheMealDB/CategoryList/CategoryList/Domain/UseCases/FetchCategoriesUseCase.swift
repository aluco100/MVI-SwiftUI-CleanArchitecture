//
//  FetchCategoriesUseCase.swift
//  CategoryList
//
//  Created by Alfredo Luco on 25-06-21.
//

import Foundation
import Combine
import DataRepos

// MARK: - Use Case Definition

protocol FetchCategories {
    var categoryGateway: CategoryGateway {get set}
}

// MARK: - Use Case Implementation

extension FetchCategories {
    
    // MARK: - Get Categories
    
    func getCategories() -> AnyPublisher<[CategoryResult], Error> {
        categoryGateway
            .getCategories()
            .map { categoriesObject in
                categoriesObject.map { category in
                    CategoryResult(id: category.idCategory ?? "N/A",
                                   name: category.strCategory ?? "N/A",
                                   thumbnail: category.strCategoryThumb ?? "",
                                   description: category.strCategoryDescription ?? "")
                }
            }
            .eraseToAnyPublisher()
    }
}

