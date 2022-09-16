//
//  LogOutViewModel.swift
//  Catpedia (iOS)
//
//  Created by Celia on 14/9/22.
//

import Foundation
import Combine

class LogOutViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private unowned let coordinator: LogOutCoordinator

    init(coordinator: LogOutCoordinator) {
        self.coordinator = coordinator

    }

    func logOut() {
        coordinator.closeSession()
    }
    // MARK: - Private
}
