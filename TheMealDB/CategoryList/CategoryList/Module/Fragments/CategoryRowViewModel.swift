//
//  CategoryRowViewModel.swift
//  CategoryList
//
//  Created by Alfredo Luco on 25-06-21.
//

import Foundation
import Combine

class CategoryRowViewModel: ObservableObject {
    @Published var imageData: Data = Data()
    fileprivate var subscriptions = Set<AnyCancellable>()
    
    func downloadImage(_ link: String) {
        guard let url = URL(string: link) else { return }
        URLSession.shared
            .dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .sink(receiveCompletion: {_ in}) { data in
                self.imageData = data
            }
            .store(in: &subscriptions)
    }
}
