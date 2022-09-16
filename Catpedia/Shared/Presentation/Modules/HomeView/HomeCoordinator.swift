//
//  TabCoordinator.swift
//  Catpedia (iOS)
//
//  Created by Celia on 13/9/22.
//

import Foundation

protocol HomeNavigationProtocol: AnyObject {
    func closeHome()
}

class HomeCoordinator: ObservableObject, Identifiable {
    
    @Published var viewModel: HomeViewModel!
    private unowned let parent: HomeNavigationProtocol
    
    @Published var catListCoordinator: CatListCoordinator!
    @Published var logOutCoordinator: LogOutCoordinator!
    @Published var favoriteListCoordinator: FavoriteListCoordinator!
    
    init(parent: HomeNavigationProtocol) {
        self.parent = parent
        self.viewModel = MainDependencyInjector.shared.getHomeViewModel(coordinator: self)
        self.catListCoordinator = CatListCoordinator(parent: self, breeds: [])
        self.logOutCoordinator = LogOutCoordinator(parent: self)
        self.favoriteListCoordinator = FavoriteListCoordinator(parent: self, breeds: [])
    }
    
    func closeHome() {
        parent.closeHome()
    }
    
    func setBreedsViewModel(breeds: [BreedsResponseDomainModel]) {
        DispatchQueue.main.async {
            self.catListCoordinator = CatListCoordinator(parent: self, breeds: breeds)
            self.favoriteListCoordinator = FavoriteListCoordinator(parent: self, breeds: breeds)
        }
    }
}

extension HomeCoordinator: CatListNavigationProtocol {
}

extension HomeCoordinator: LogOutNavigationProtocol {
    func closeSession() {
        self.closeHome()
    }
}

extension HomeCoordinator: FavoriteListNavigationProtocol {
    
}
