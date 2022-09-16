//
//  CatListViewModel.swift
//  Catpedia (iOS)
//
//  Created by Celia on 9/9/22.
//

import Foundation
import Combine
import SwiftUI

class CatListViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var searchedText: String = ""
    @Published var favoritesBreedsID: [String] = []

    let breeds: [BreedsResponseDomainModel]
    private let getFavoritesUseCase: GetFavoritesBreedsUseCase
    private let setFavoritesUseCase: SetFavoritesBreedsUseCase

    private unowned let coordinator: CatListCoordinator

    init(coordinator: CatListCoordinator,
         getFavoritesUseCase: GetFavoritesBreedsUseCase,
         setFavoritesUseCase: SetFavoritesBreedsUseCase,
         breeds: [BreedsResponseDomainModel]) {
        self.coordinator = coordinator
        self.getFavoritesUseCase = getFavoritesUseCase
        self.setFavoritesUseCase = setFavoritesUseCase
        self.breeds = breeds
        self.getFavoriteList()
    }
    
    func getFavoriteList() {
        DispatchQueue.main.async {
            self.getFavoritesUseCase.getData { result in
                switch result {
                case .success(let favoriteList):
                    self.favoritesBreedsID = favoriteList
                case .failure(_):
                    print("Error fetichg favorite Breeds")
                }
            }
        }
    }
    
    func addToLike(id: String) {
        favoritesBreedsID.append(id)
        self.uploadDataBase()
    }
    
    func removeFromLike(id: String) {
        favoritesBreedsID = favoritesBreedsID.filter{ $0 != id }
        self.uploadDataBase()
    }
    
    func uploadDataBase() {
        setFavoritesUseCase.getData(requestModel: SetFavoritesBreedRequesDomainModel(favoritesIds: favoritesBreedsID)) { result in
            switch result {
            case .success(_):
                print("Log that everithing goes right")
            case .failure(_):
                print("Fails in save data to UserDefaults")
                //Show a alert of something
            }
        }
    }
    
    func goToDetailbreed(breed: BreedsResponseDomainModel) {
        coordinator.goToDetailBreed(breed: breed)
    }
}
