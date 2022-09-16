//
//  UserDefaultsDataRepository.swift
//  Catpedia (iOS)
//
//  Created by Celia on 14/9/22.
//

import Foundation

public protocol UserDefaultsDataRepository {
    func save(object: [String],
              key: String,
              completion: @escaping (Result<Void, Error>) -> Void)

    func get(key: String,
             completion: @escaping (Result<[String], Error>) -> Void)

    func delete(key: String,
                completion: @escaping (Result<Void, Error>) -> Void)
    
}
