//
//  CategoryListView.swift
//  CategoryList
//
//  Created by Alfredo Luco on 25-06-21.
//

import SwiftUI

public struct CategoryListView: View {
    
    public init() {
        presenter = CategoryListPresenter()
    }
    
    @ObservedObject public var presenter: CategoryListPresenter
    
    public var body: some View {
        VStack {
            NavigationView {
                Group {
                    if self.presenter.isLoading {
                        VStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    }else {
                        List {
                            ForEach(presenter.categories) { category in
                                CategoryRow(category: category, viewModel: CategoryRowViewModel())
                            }
                        }
                    }
                }.alert(isPresented: self.$presenter.hasError, content: {
                    Alert(title: Text("Error!"), message: Text(self.presenter.errorMessage), dismissButton: .cancel())
                })
                .navigationTitle("Categories")
            }
            
        }
        .onAppear(perform: {
            self.presenter.fetchCategories()
        })
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView()
    }
}
