//
//  SetFavoritesBrewsUseCase.swift
//  Catpedia (iOS)
//
//  Created by Celia on 14/9/22.
//

import Foundation

public class SetFavoritesBreedsUseCase: BaseUseCase {
    
    typealias Input = SetFavoritesBreedRequesDomainModel
    typealias Output = Void
    
    private let userDefaultsRepository: UserDefaultsDataRepository
    
    public init(userDefaultsRepository: UserDefaultsDataRepository) {
        self.userDefaultsRepository = userDefaultsRepository
    }
    
    func getData(requestModel: SetFavoritesBreedRequesDomainModel,
                 completion: @escaping (Result<Void, Error>) -> Void) {
        return userDefaultsRepository.save(object: requestModel.favoritesIds, key: "Favorites", completion: completion)
        
    }
}
