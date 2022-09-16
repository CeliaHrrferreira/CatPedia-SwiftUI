//
//  CatListCoordinator.swift
//  Catpedia (iOS)
//
//  Created by Celia on 9/9/22.
//

import Foundation

protocol CatListNavigationProtocol: AnyObject {
}

class CatListCoordinator: ObservableObject, Identifiable {
    
    @Published var viewModel: CatListViewModel!
    @Published var catDetailCoordinator: CatDetailCoordinator!
    private unowned let parent: CatListNavigationProtocol

    init(parent: CatListNavigationProtocol, breeds: [BreedsResponseDomainModel]) {
        self.parent = parent
        self.viewModel = MainDependencyInjector.shared.getCatListViewModel(coordinator: self, breeds: breeds)
    }
    
    func goToDetailBreed(breed: BreedsResponseDomainModel) {
        catDetailCoordinator = CatDetailCoordinator(parent: self, breed: breed)
    }
    
}

// MARK: NavigationProtocols
extension CatListCoordinator: CatDetailNavigationProtocol {
    func closeDetail() {
        catDetailCoordinator = nil
    }
}


