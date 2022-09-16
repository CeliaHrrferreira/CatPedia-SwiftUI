//
//  FavoriteListView.swift
//  Favoritepedia (iOS)
//
//  Created by Celia on 14/9/22.
//

import SwiftUI

struct FavoriteListView: View {
    @ObservedObject var viewModel: FavoriteListViewModel
    @ObservedObject var coordinator: FavoriteListCoordinator
    
    var body: some View {
        NavigationView {
            
            if viewModel.favoritesBreedsID.isEmpty {
                Text("Add cats to favorite")
            } else {
                List {
                    ForEach(searchResultsBews, id: \.self) { breed in
                        if viewModel.favoritesBreedsID.contains(breed.id) {
                            CatCardView(breed: breed,
                                        pressPhoto: {
                                viewModel.goToDetailFavoritebreed(breed: breed)
                            }, pressLike: {
                                if !viewModel.favoritesBreedsID.contains(breed.id) {
                                    viewModel.addToLike(id: breed.id)
                                } else  {
                                    viewModel.removeFromLike(id: breed.id)
                                }
                            }, isLiked: viewModel.favoritesBreedsID.contains(breed.id))
                        }
                    }
                }
                .navigation(item: $coordinator.catDetailCoordinator) { coordinator in
                    CatDetailView(coordinator: coordinator, viewModel: coordinator.viewModel)
                }
            }
                
        }
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $viewModel.searchedText)
        .navigationTitle("Favorites")
        .listStyle(GroupedListStyle())
        
        
    }
    
    var searchResultsBews: [BreedsResponseDomainModel] {
        if viewModel.searchedText.isEmpty {
            return viewModel.breeds
        } else {
            return viewModel.breeds.filter { $0.name.contains(viewModel.searchedText) }
        }
    }
}
