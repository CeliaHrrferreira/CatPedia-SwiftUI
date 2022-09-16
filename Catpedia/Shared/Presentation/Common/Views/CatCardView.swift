//
//  CatCardView.swift
//  Catpedia (iOS)
//
//  Created by Celia on 9/9/22.
//

import SwiftUI
import Kingfisher

struct CatCardView: View {
    let breed: BreedsResponseDomainModel
    var pressPhoto: () -> Void
    var pressLike: () -> Void
    
    var resource: Resource {
        if let url =  URL(string: breed.image?.url ?? "") {
            return  ImageResource(downloadURL: url, cacheKey: breed.id)
        } else  {
            return ImageResource(downloadURL: URL(string: breed.image?.url ?? "")!)
        }
    }
    
    @State var isLiked: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
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
                .frame(width: UIScreen.main.bounds.width - 40,
                       height: UIScreen.main.bounds.width - 40)
                .clipped()
                .shadow(radius: 5)
                .onTapGesture {
                    pressPhoto()
                }
            
            HStack {
                Text( breed.name)
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(systemName: isLiked ? "heart.fill" : "heart")
                    .onTapGesture {
                        pressLike()
                        withAnimation {
                            isLiked.toggle()
                        }
                    }
                
            }.padding()
                .frame(width: UIScreen.main.bounds.width - 40, height: 60)
                .background(Color.accentBrown)
        }.cornerRadius(20)
        
        
    }
}
