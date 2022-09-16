//
//  LogOutView.swift
//  Catpedia (iOS)
//
//  Created by Celia on 14/9/22.
//

import SwiftUI

struct LogOutView: View {
    
    @ObservedObject var coordinator: LogOutCoordinator
    @ObservedObject var viewModel: LogOutViewModel
    
    var body: some View {
        VStack {
            Text("Thanks")
                .padding(.bottom, 24)
            
            Image("cat")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
            
            Button {
                viewModel.logOut()
            } label: {
                HStack {
                    Spacer()
                    Text("Log Out")
                    Spacer()
                }
                .frame(height: 45)
                .background(RoundedRectangle(cornerRadius: 8)
                    .fill( Color.principalPink))
                .foregroundColor(.white)
                .cornerRadius(12)
            }
            .padding(.top, 24)
        }
        .padding()
        
    }
}
