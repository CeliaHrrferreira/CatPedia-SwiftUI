//
//  TabViewModel.swift
//  Catpedia (iOS)
//
//  Created by Celia on 13/9/22.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private unowned let coordinator: HomeCoordinator
    
    @Published var breeds: [BreedsResponseDomainModel] = []
    private let getbreedsUseCase: GetbreedsUseCase
    
    
    init(coordinator: HomeCoordinator, getbreedsUseCase: GetbreedsUseCase) {
        self.coordinator = coordinator
        self.getbreedsUseCase = getbreedsUseCase
        self.getCatList()
    }
    
    func getCatList() {
        getbreedsUseCase.getData { result in
            switch result {
            case .success(let listbreeds):
                DispatchQueue.main.async {
                    self.breeds = listbreeds
                    self.coordinator.setBreedsViewModel(breeds: listbreeds)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Private
}
