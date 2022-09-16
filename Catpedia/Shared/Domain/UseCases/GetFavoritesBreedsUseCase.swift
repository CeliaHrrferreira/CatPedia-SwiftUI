//
//  GetFavoritesBreedsUseCase.swift
//  Catpedia (iOS)
//
//  Created by Celia on 14/9/22.
//

import Foundation

public class GetFavoritesBreedsUseCase: BaseUseCase {
    
    typealias Input = Void
    typealias Output = GetFavoritesBreedRequesDomainModel
    
    private let userDefaultsRepository: UserDefaultsDataRepository
    
    public init(userDefaultsRepository: UserDefaultsDataRepository) {
        self.userDefaultsRepository = userDefaultsRepository
    }
    
    func getData(completion: @escaping (Result<[String], Error>) -> Void) {
        
        return userDefaultsRepository.get(key: "Favorites") { result in
            switch result {
            case .success(let favorites):
                if let favorites = favorites as? [String] {
                    
                    completion(.success(favorites))
                } else {
                    self.userDefaultsRepository.save(object: [],
                                                     key: "Favorites") { _ in }
                    completion(.success([]))
                }
            case .failure(let error):
                self.userDefaultsRepository.save(object: [],
                                                 key: "Favorites") { _ in }
                completion(.failure(error))
            }
        }
    }
}
