//
//  MainHttpDataSource.swift
//  Catpedia (iOS)
//
//  Created by Celia on 9/9/22.
//

import Foundation
import Combine

public class MainHttpDataSource: MainHttpDataRespository {
    
    // MARK: - Singleton
    
    private static var repositoryInstance: MainHttpDataSource?
    
    public static func shared() -> MainHttpDataRespository {
        if let repositoryInstance = MainHttpDataSource.repositoryInstance {
            return repositoryInstance
        } else {
            
            MainHttpDataSource.repositoryInstance = MainHttpDataSource()
            return MainHttpDataSource.repositoryInstance!
        }
    }
    
    public func getbreedList(completion: @escaping (Result<[BreedsResponseDomainModel], Error>) -> Void) {
        
        guard let url = URL(string: "https://api.thecatapi.com/v1/breeds") else {
            return completion(.failure(NSError(domain: "URL invalid", code: 404, userInfo: nil)))
        }
        
        URLSession.shared.dataTask(with: url){(data, response, error) in
            if error != nil{
                completion(.failure(error!))
                print(error!)
            } else{
                guard let _ = response as? HTTPURLResponse, let jsonData = data  else { return }
                let breedList = try? JSONDecoder().decode(BreedsResponseDataModel.self, from: jsonData)
                if let breedsListDomainModel = breedList?.parseToDomainModel() {
                    completion(.success(breedsListDomainModel))
                } else {
                    completion(.failure(NSError(domain: "Error from data to model", code: 404, userInfo: nil)))
                }
            }
        }.resume()
    }
}

