//
//  getbreedsUseCase.swift
//  Catpedia (iOS)
//
//  Created by Celia on 10/9/22.
//

import Foundation
class GetbreedsUseCase: BaseUseCase {
    
    typealias Input = Never
    typealias Output = [BreedsResponseDomainModel]
    
    private let repository: MainHttpDataRespository
    
    public init(repository: MainHttpDataRespository) {
        self.repository = repository
    }

    func getData(completion: @escaping (Result<[BreedsResponseDomainModel], Error>) -> Void) {
        
        return repository.getbreedList { result in
            switch result {
            case .success(let breeds):
                completion(.success(breeds))
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }
}
