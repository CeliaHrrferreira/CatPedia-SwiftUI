//
//  LoginViewModel.swift
//  Catpedia (iOS)
//
//  Created by Celia on 9/9/22.
//

import Foundation
import Combine
import SwiftUI
import Firebase

class LoginViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showLoading: Bool = false

    @Published var coordinator: LoginCoordinator

    init(coordinator: LoginCoordinator) {
        self.coordinator = coordinator
    }
    
    func loginPressed() {
        self.coordinator.goToHome()
    }
    
    func test() {
        showLoading = true
           
           Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
               
               guard error == nil else {
                   self.showLoading = false
                   return
               }
               switch authResult {
               case .none:
                   print("Could not sign in user.")
                   self.showLoading = false
               case .some(_):
                   print("User signed in")
                   self.showLoading = false
                   withAnimation {
                       self.coordinator.goToHome()
                   }
               }
               
           }
        
    }
    
    func goToRegister() {
        self.coordinator.openRegister()
    }
    
    // MARK: - Private
}

