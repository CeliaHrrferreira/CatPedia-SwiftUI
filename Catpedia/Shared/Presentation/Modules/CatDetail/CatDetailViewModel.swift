//
//  CatDetailViewModel.swift
//  Catpedia (iOS)
//
//  Created by Celia on 9/9/22.
//

import Foundation
import Combine
import SwiftUI

class CatDetailViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private unowned let coordinator: CatDetailCoordinator
    let breed: BreedsResponseDomainModel

    init(coordinator: CatDetailCoordinator, breed: BreedsResponseDomainModel) {
        self.coordinator = coordinator
        self.breed = breed
    }
    
    func closeDetail() {
        coordinator.closeDetail()
    }

    // MARK: - Private
}
