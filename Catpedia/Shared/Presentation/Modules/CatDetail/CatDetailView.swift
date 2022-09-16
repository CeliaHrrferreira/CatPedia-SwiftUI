//
//  CatDetailView.swift
//  Catpedia (iOS)
//
//  Created by Celia on 9/9/22.
//

import SwiftUI
import Kingfisher

struct CatDetailView: View {
    
    @ObservedObject var coordinator: CatDetailCoordinator
    @ObservedObject var viewModel: CatDetailViewModel

    var resource: Resource {
        if let url =  URL(string: viewModel.breed.image?.url ?? "") {
            return  ImageResource(downloadURL: url, cacheKey: viewModel.breed.id)
        } else  {
            return ImageResource(downloadURL: URL(string: viewModel.breed.image?.url ?? "")!)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                KFImage(source: .network(resource))
                .placeholder {
                    Image("cat_love")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width - 60,
                               height: UIScreen.main.bounds.width - 60)
                    }
                .cacheOriginalImage()
                .cancelOnDisappear(true)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width ,
                       height: UIScreen.main.bounds.width )
                .clipped()
                
                
                HStack {
                    Text(viewModel.breed.name.uppercased())
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.leading, 12)
                        .padding(.vertical, 12)
                        
                    Spacer()
                }
                .background(Color.principalPink)
                .offset(y: -10)
                
                Text(viewModel.breed.welcomeDescription)
                    .font(.body)
                    .padding()
                
                Text("Origin: " + viewModel.breed.origin)
                    .font(.body)
                    .fontWeight(.bold)
                    .padding()
                
                Text("Weight: " + viewModel.breed.weight.metric + " kg")
                    .font(.body)
                    .fontWeight(.bold)
                    .padding()
            }
        }
        .ignoresSafeArea(.all)
        
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(id: "Back", placement: .navigationBarLeading) {
                Button {
                    viewModel.closeDetail()
                } label: {
                    Image(systemName: "arrow.backward")
                }

            }
        }
    }
}
