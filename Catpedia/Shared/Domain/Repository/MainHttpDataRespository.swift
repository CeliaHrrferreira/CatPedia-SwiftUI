//
//  MainHttpDataRespository.swift
//  Catpedia (iOS)
//
//  Created by Celia on 9/9/22.
//

import Foundation

public protocol MainHttpDataRespository {
    func getbreedList(completion: @escaping (Result<[BreedsResponseDomainModel], Error>) -> Void)
}
