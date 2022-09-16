//
//  FavoriteListCoordinator.swift
//  Favoritepedia (iOS)
//
//  Created by Celia on 14/9/22.
//


import Foundation

protocol FavoriteListNavigationProtocol: AnyObject {
}

class FavoriteListCoordinator: ObservableObject, Identifiable {
    
    @Published var viewModel: FavoriteListViewModel!
    @Published var catDetailCoordinator: CatDetailCoordinator!
    private unowned let parent: FavoriteListNavigationProtocol

    init(parent: FavoriteListNavigationProtocol, breeds: [BreedsResponseDomainModel]) {
        self.parent = parent
        self.viewModel = MainDependencyInjector.shared.getFavoriteListViewModel(coordinator: self, breeds: breeds)
    }
    
    func goToDetailBreed(breed: BreedsResponseDomainModel) {
        self.catDetailCoordinator = CatDetailCoordinator(parent: self, breed: breed)
    }
}

extension FavoriteListCoordinator: CatDetailNavigationProtocol {
    func closeDetail() {
        catDetailCoordinator = nil
    }
}
