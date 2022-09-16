//
//  LoginView.swift
//  Catpedia (iOS)
//
//  Created by Celia on 9/9/22.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var coordinator: LoginCoordinator
    @ObservedObject var viewModel: LoginViewModel
    
    init(coordinator: LoginCoordinator,
         viewModel: LoginViewModel) {
        self.viewModel = viewModel
        self.coordinator = coordinator
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                
                Image("cat")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                
                Text("Enter to explore differents Cats Breeds")
                    .padding()
                
                
                TextField("Email", text: $viewModel.email)
                    .padding()
                    .background {
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill( viewModel.email == "" ? Color.black.opacity(0.05) : Color("Orange"))
                    }
                    .textInputAutocapitalization(.never)
                    .padding(.top,20)
                
                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background {
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill( viewModel.password == "" ? Color.black.opacity(0.05) : Color("Orange"))
                    }
                    .textInputAutocapitalization(.never)
                    .padding(.top,8)
                
                Button {
                    viewModel.loginPressed()
                } label: {
                    HStack {
                        Spacer()
                        Text("Sing in")
                        Spacer()
                    }
                    .frame(height: 45)
                    .background(RoundedRectangle(cornerRadius: 8)
                        .fill( Color.principalPink))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .padding(.top, 12)
                
                
                Button {
                    viewModel.goToRegister()
                } label: {
                    Text("Don't have an account, Sing Up")
                }
                .foregroundColor(.principalPink)
                
                Spacer()
                
            }
            .padding()
            .navigation(item: $coordinator.registerCoordinator) { coordinator in
                RegisterView(coordinator: coordinator, viewModel: coordinator.viewModel)
            }
            
            .fullScreenCover(item: $coordinator.homeCoordinator) { coordinator in
                HomeView(coordinator: coordinator, viewModel: coordinator.viewModel)
            }
            .navigationTitle("")
            
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}


//
//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
