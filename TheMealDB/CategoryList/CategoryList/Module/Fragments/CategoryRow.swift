//
//  CategoryRow.swift
//  CategoryList
//
//  Created by Alfredo Luco on 25-06-21.
//

import SwiftUI
import Combine

struct CategoryRow: View {
    
    var category: CategoryResult
    @ObservedObject var viewModel: CategoryRowViewModel
    
    var body: some View {
        HStack {
            VStack {
                Image(uiImage: UIImage(data: viewModel.imageData) ?? UIImage())
                    .resizable()
                    .aspectRatio(1.0, contentMode: .fit)
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .cornerRadius(8.0)
                Spacer()
            }.padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            
            VStack {
                Text(category.name).font(.largeTitle)
                Text(category.description).font(.caption2)
            }
        }.padding()
        .onAppear {
            viewModel.downloadImage(self.category.thumbnail)
        }
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRow(category: CategoryResult(id: "dsdsas", name: "Test", thumbnail: "https://www.duplos.cl/wp-content/uploads/2021/04/hipertextual-apple-firma-unos-resultados-trimestrales-marcados-pandemia-coronavirus-2020631833-scaled-1.jpg", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."), viewModel: CategoryRowViewModel())
    }
}
