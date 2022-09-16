//
//  LoginCoordinator.swift
//  Catpedia (iOS)
//
//  Created by Celia on 9/9/22.
//

import Foundation
import Combine

class LoginCoordinator: ObservableObject {
    
    @Published var viewModel: LoginViewModel!
    @Published var homeCoordinator: HomeCoordinator? = nil

    init() {
        self.viewModel = .init(coordinator: self)
    }
    
    
    @Published var registerCoordinator: RegisterCoordinator?

    func openRegister() {
        self.registerCoordinator = RegisterCoordinator(parent: self)
    }
    
    func goToHome() {
        self.homeCoordinator = HomeCoordinator(parent: self)
    }

}

extension LoginCoordinator: RegisterNavigationProtocol {
    func closeRegister() {
        registerCoordinator = nil
    }
    func closeRegisterAndEnter() {
        registerCoordinator = nil
        self.goToHome()
    }
}

extension LoginCoordinator: HomeNavigationProtocol {
    func closeHome() {
        homeCoordinator = nil
    }
    
}

extension LoginCoordinator {
   public static var sample: LoginCoordinator {
       return LoginCoordinator()
    }
}
