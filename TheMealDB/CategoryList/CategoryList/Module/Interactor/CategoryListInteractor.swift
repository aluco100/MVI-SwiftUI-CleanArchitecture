//
//  CategoryListInteractor.swift
//  CategoryList
//
//  Created by Alfredo Luco on 25-06-21.
//

import Foundation
import Combine
import DataRepos

class CategoryListInteractor {
    
    // MARK: - Properties
    
    var worker: CategoryWorker = CategoryWorker(CategoryAPIRepository())
    weak var presenter: CategoryListPresenter?
    fileprivate var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Fetch categories
    
    func fetchCategories() {
        worker.getCategories()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.presenter?.hasError = true
                    self.presenter?.errorMessage = error.localizedDescription
                    break
                case .finished:
                    break
                }
                self.presenter?.isLoading = false
            }) { categories in
                self.presenter?.categories = categories
            }
            .store(in: &subscriptions)
    }
}
