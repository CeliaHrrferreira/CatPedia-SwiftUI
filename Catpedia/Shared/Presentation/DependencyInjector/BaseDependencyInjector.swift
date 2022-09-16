//
//  BaseDependencyInjector.swift
//  Catpedia (iOS)
//
//  Created by Celia on 10/9/22.
//

import Foundation

internal class BaseDependencyInjector {
    
    static let baseShared = BaseDependencyInjector()

    internal func getbreedsUseCase() -> GetbreedsUseCase {
        return GetbreedsUseCase(repository: getHttRepository())
    }
    
    internal func getFavoriteBreedsUseCase() -> GetFavoritesBreedsUseCase {
        return GetFavoritesBreedsUseCase(userDefaultsRepository: getUserDefaults())
    }
    
    internal func setFavoriteBreedsUseCase() -> SetFavoritesBreedsUseCase {
        return SetFavoritesBreedsUseCase(userDefaultsRepository: getUserDefaults())
    }

}

// MARK: Repositories
extension BaseDependencyInjector {
    func getHttRepository() -> MainHttpDataRespository {
        return MainHttpDataSource.shared()
    }
    
    func getUserDefaults() -> UserDefaultsDataRepository {
        return UserDefaultsDatSource.shared()
    }
}
