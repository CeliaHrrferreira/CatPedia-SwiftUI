//
//  RegisterCoordinator.swift
//  Catpedia (iOS)
//
//  Created by Celia on 9/9/22.
//

import Foundation

protocol RegisterNavigationProtocol: AnyObject {
    func closeRegister()
    func closeRegisterAndEnter()
}

class RegisterCoordinator: ObservableObject {
    
    @Published var viewModel: RegisterViewModel!
    private unowned let parent: RegisterNavigationProtocol

    init(parent: RegisterNavigationProtocol) {
        self.parent = parent
        self.viewModel = .init(coordinator: self)
    }
    
    func closeRegister() {
        parent.closeRegister()
    }
    
    func closeRegisterAndEnter() {
        parent.closeRegisterAndEnter()
    }

}
