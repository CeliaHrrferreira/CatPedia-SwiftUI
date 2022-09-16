//
//  CatDetailCoordinator.swift
//  Catpedia (iOS)
//
//  Created by Celia on 9/9/22.
//

import Foundation

protocol CatDetailNavigationProtocol: AnyObject {
    func closeDetail()
}

class CatDetailCoordinator: ObservableObject, Identifiable {
    
    @Published var viewModel: CatDetailViewModel!
    
    private unowned let parent: CatDetailNavigationProtocol

    init(parent: CatDetailNavigationProtocol, breed: BreedsResponseDomainModel) {
        self.parent = parent
        self.viewModel = .init(coordinator: self, breed: breed)
    }
    
    func closeDetail() {
        parent.closeDetail()
    }

}
