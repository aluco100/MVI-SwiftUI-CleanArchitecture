//
//  CategoryListPresenter.swift
//  CategoryList
//
//  Created by Alfredo Luco on 25-06-21.
//

import Foundation

public class CategoryListPresenter: ObservableObject {
    
    // MARK: - Properties
    
    var interactor: CategoryListInteractor?
    @Published var isLoading: Bool = true
    @Published var categories: [CategoryResult] = []
    @Published var hasError: Bool = false
    @Published var errorMessage: String = ""
    
    // MARK: - Init
    
    public init() {
        interactor = CategoryListInteractor()
        interactor?.presenter = self
    }
    
    // MARK: - Fetch Categories
    
    func fetchCategories() {
        interactor?.fetchCategories()
    }
}
