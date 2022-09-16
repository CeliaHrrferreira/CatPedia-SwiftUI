//
//  RegisterView.swift
//  Catpedia (iOS)
//
//  Created by Celia on 9/9/22.
//

import SwiftUI

struct RegisterView: View {
    
    @ObservedObject var coordinator: RegisterCoordinator
    @ObservedObject var viewModel: RegisterViewModel
    
    var body: some View {
        VStack {
            Image("cat_edit")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
            
            TextField("Email", text: $viewModel.email)
                .padding()
                .background {
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            
                            viewModel.email == "" ? Color.black.opacity(0.05) : Color("Orange")
                        )
                }
                .textInputAutocapitalization(.never)
                .padding(.top,20)
            
            SecureField("Password", text: $viewModel.password)
                .padding()
                .background {
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            
                            viewModel.password == "" ? Color.black.opacity(0.05) : Color("Orange")
                        )
                }
                .textInputAutocapitalization(.never)
                .padding(.top,15)
            
            Button {
                viewModel.register()
            } label: {
                HStack {
                    Spacer()
                    Text("Sing up")
                    Spacer()
                }
                .frame(height: 45)
                .background(RoundedRectangle(cornerRadius: 8)
                    .fill( Color.principalPink))
                .foregroundColor(.white)
            }
            .padding(.top, 20)
            
            Spacer()
            
        }
        .padding()
        .navigationTitle("Sing up")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(id: "Back", placement: .navigationBarLeading) {
                Button {
                    viewModel.closeRegister()
                } label: {
                    Image(systemName: "arrow.backward")
                }

            }
        }
    }
}
//
//struct RegisterView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegisterView()
//    }
//}
