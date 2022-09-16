//
//  BreedsResponseDataModel.swift
//  Catpedia (iOS)
//
//  Created by Celia on 9/9/22.
//

import Foundation

public struct BreedsResponseDomainModel: Hashable {
    let weight: CatWeightTypeDomainModel
    let id, name: String
    let cfaURL: String?
    let vetstreetURL: String?
    let vcahospitalsURL: String?
    let temperament, origin, countryCodes, countryCode: String
    let welcomeDescription, lifeSpan: String
    let indoor: Int
    let lap: Int?
    let altNames: String?
    let adaptability, affectionLevel, childFriendly, dogFriendly: Int
    let energyLevel, grooming, healthIssues, intelligence: Int
    let sheddingLevel, socialNeeds, strangerFriendly, vocalisation: Int
    let experimental, hairless, natural, rare: Int
    let rex, suppressedTail, shortLegs: Int
    let wikipediaURL: String?
    let hypoallergenic: Int
    let referenceImageID: String?
    let image: CatImageDomainModel?
    let catFriendly, bidability: Int?
}

extension BreedsResponseDomainModel {
    static public var sample: BreedsResponseDomainModel {
        return BreedsResponseDomainModel(weight: CatWeightTypeDomainModel(imperial: "10", metric: "20"),
                                         id: "0",
                                         name: "Common",
                                         cfaURL: nil,
                                         vetstreetURL: nil,
                                         vcahospitalsURL: nil,
                                         temperament: "calm",
                                         origin: "uknown",
                                         countryCodes: "eu",
                                         countryCode: "eu",
                                         welcomeDescription: "The normal cat in europe",
                                         lifeSpan: "10",
                                         indoor: 0,
                                         lap: nil,
                                         altNames: nil,
                                         adaptability: 4,
                                         affectionLevel: 3,
                                         childFriendly: 2,
                                         dogFriendly: 1,
                                         energyLevel: 3,
                                         grooming: 4,
                                         healthIssues: 4,
                                         intelligence: 5,
                                         sheddingLevel: 4,
                                         socialNeeds: 2,
                                         strangerFriendly: 3,
                                         vocalisation: 3,
                                         experimental: 1,
                                         hairless: 0,
                                         natural: 5,
                                         rare: 0,
                                         rex: 3,
                                         suppressedTail: 1,
                                         shortLegs: 0,
                                         wikipediaURL: nil,
                                         hypoallergenic: 0,
                                         referenceImageID: nil,
                                         image: nil,
                                         catFriendly: 4,
                                         bidability: 3)
    }
}

public struct CatImageDomainModel: Hashable {
    let id: String
    let width, height: Int
    let url: String
}

public struct CatWeightTypeDomainModel: Hashable {
    let imperial, metric: String
}


