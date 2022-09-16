//
//  APIResponse.swift
//  Catpedia (iOS)
//
//  Created by Celia on 9/9/22.
//

import Foundation

protocol APIResponse: Decodable {
}

extension Decodable {

    init(data: Data) throws {
        self = try JSONDecoder().decode(Self.self, from: data)
    }
}
