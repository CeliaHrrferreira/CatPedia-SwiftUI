//
//  LogOutCoordinator.swift
//  Catpedia (iOS)
//
//  Created by Celia on 14/9/22.
//

import Foundation

protocol LogOutNavigationProtocol: AnyObject {
    func closeSession()
}

class LogOutCoordinator: ObservableObject, Identifiable {
    
    @Published var viewModel: LogOutViewModel!
    private unowned let parent: LogOutNavigationProtocol
    
    init(parent: LogOutNavigationProtocol) {
        self.parent = parent
        self.viewModel = .init(coordinator: self)
    }
    
    func closeSession() {
        parent.closeSession()
    }
}
