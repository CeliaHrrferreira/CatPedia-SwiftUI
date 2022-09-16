//
//  RegisterViewModel.swift
//  Catpedia (iOS)
//
//  Created by Celia on 9/9/22.
//

import Foundation
import Combine
import SwiftUI
import Firebase

class RegisterViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showLoading: Bool = false
    
    
    private unowned let coordinator: RegisterCoordinator

    init(coordinator: RegisterCoordinator) {
        self.coordinator = coordinator

    }
    
    func closeRegister() {
        coordinator.closeRegister()
    }
    
    
    func register() {
        self.coordinator.closeRegisterAndEnter()
        
//        showLoading = true
//
//        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
//            guard error == nil else {
//                self.showLoading = false
//                return
//            }
//
//            switch authResult {
//            case .none:
//                print("Could not create account.")
//                self.showLoading = false
//            case .some(_):
//                print("User created")
//                self.showLoading = false
//                self.coordinator.closeRegisterAndEnter()
//            }
//        }
    }
    // MARK: - Private
}
