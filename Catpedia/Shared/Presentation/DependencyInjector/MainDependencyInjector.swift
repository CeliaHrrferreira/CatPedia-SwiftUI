//
//  MainDependencyInjector.swift
//  Catpedia (iOS)
//
//  Created by Celia on 10/9/22.
//


internal class MainDependencyInjector {
    
    internal static let shared = MainDependencyInjector()
        
    internal func getHomeViewModel(coordinator: HomeCoordinator) -> HomeViewModel {
        return HomeViewModel(coordinator: coordinator, getbreedsUseCase: BaseDependencyInjector.baseShared.getbreedsUseCase())
    }

    internal func getCatListViewModel(coordinator: CatListCoordinator, breeds: [BreedsResponseDomainModel]) -> CatListViewModel {
        return CatListViewModel(coordinator: coordinator,
                                getFavoritesUseCase: BaseDependencyInjector.baseShared.getFavoriteBreedsUseCase(),
                                setFavoritesUseCase: BaseDependencyInjector.baseShared.setFavoriteBreedsUseCase(),
                                breeds: breeds)
    }
    
    internal func getFavoriteListViewModel(coordinator: FavoriteListCoordinator, breeds: [BreedsResponseDomainModel]) -> FavoriteListViewModel {
        return FavoriteListViewModel(coordinator: coordinator,
                                     getFavoritesUseCase: BaseDependencyInjector.baseShared.getFavoriteBreedsUseCase(),
                                     setFavoritesUseCase: BaseDependencyInjector.baseShared.setFavoriteBreedsUseCase(),
                                     breeds: breeds)
    }
}
