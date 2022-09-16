//
//  MockAPIClient.swift
//  Catpedia (iOS)
//
//  Created by Celia on 9/9/22.
//

import Foundation

public final class UserDefaultsDatSource: UserDefaultsDataRepository {

    private static var repositoryInstance: UserDefaultsDatSource?

    public static func shared() -> UserDefaultsDataRepository {

        if let repositoryInstance = UserDefaultsDatSource.repositoryInstance {
            return repositoryInstance
        } else {
            UserDefaultsDatSource.repositoryInstance = UserDefaultsDatSource()
            return UserDefaultsDatSource.repositoryInstance!
        }
    }
    
    public func save(object: [String],
                     key: String,
                     completion: @escaping (Result<Void, Error>) -> Void) {

            UserDefaults.standard.set(object, forKey: key)
            UserDefaults.standard.synchronize()
            completion(.success(()))
    }

    public func get(key: String,
                    completion: @escaping (Result<[String], Error>) -> Void) {
        if let object = UserDefaults.standard.object(forKey: key) as? [String] {
                completion(.success(object))
        } else {
            completion(.failure(NSError(domain: "Object not found", code: 404, userInfo: nil)))
        }
    }

    public func delete(key: String,
                       completion: @escaping (Result<Void, Error>) -> Void) {
        UserDefaults.standard.removeObject(forKey: key)
        completion(.success(()))
    }
}
