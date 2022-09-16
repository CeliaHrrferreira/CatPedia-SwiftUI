//
//  CatListView.swift
//  Catpedia (iOS)
//
//  Created by Celia on 9/9/22.
//

import SwiftUI

struct CatListView: View {
    @ObservedObject var coordinator: CatListCoordinator
    @ObservedObject var viewModel: CatListViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(searchResultsBews, id: \.self) { breed in
                    CatCardView(breed: breed,
                                pressPhoto: {
                        viewModel.goToDetailbreed(breed: breed)
                    }, pressLike: {
                        if !viewModel.favoritesBreedsID.contains(breed.id) {
                            viewModel.addToLike(id: breed.id)
                        } else  {
                            viewModel.removeFromLike(id: breed.id)
                        }
                    }, isLiked: viewModel.favoritesBreedsID.contains(breed.id))
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $viewModel.searchedText)
            .navigationTitle("Breeds")
            .listStyle(GroupedListStyle())
            .navigation(item: $coordinator.catDetailCoordinator) { coordinator in
                CatDetailView(coordinator: coordinator, viewModel: coordinator.viewModel)
            }
            
        }
        
    }
    
    var searchResultsBews: [BreedsResponseDomainModel] {
        if viewModel.searchedText.isEmpty {
            return viewModel.breeds
        } else {
            return viewModel.breeds.filter { $0.name.contains(viewModel.searchedText) }
        }
    }
}
