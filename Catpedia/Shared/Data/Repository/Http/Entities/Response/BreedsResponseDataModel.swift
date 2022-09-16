//
//  BreedsResponseDataModel.swift
//  Catpedia (iOS)
//
//  Created by Celia on 9/9/22.
//

import Foundation

// MARK: - WelcomeElement

typealias BreedsResponseDataModel = [Breed]

struct Breed: Codable {
    let catWeight: CatWeightType
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
    let image: CatImage?
    let catFriendly, bidability: Int?

    enum CodingKeys: String, CodingKey {
        case catWeight = "weight"
        case id, name
        case cfaURL = "cfa_url"
        case vetstreetURL = "vetstreet_url"
        case vcahospitalsURL = "vcahospitals_url"
        case temperament, origin
        case countryCodes = "country_codes"
        case countryCode = "country_code"
        case welcomeDescription = "description"
        case lifeSpan = "life_span"
        case indoor, lap
        case altNames = "alt_names"
        case adaptability
        case affectionLevel = "affection_level"
        case childFriendly = "child_friendly"
        case dogFriendly = "dog_friendly"
        case energyLevel = "energy_level"
        case grooming
        case healthIssues = "health_issues"
        case intelligence
        case sheddingLevel = "shedding_level"
        case socialNeeds = "social_needs"
        case strangerFriendly = "stranger_friendly"
        case vocalisation, experimental, hairless, natural, rare, rex
        case suppressedTail = "suppressed_tail"
        case shortLegs = "short_legs"
        case wikipediaURL = "wikipedia_url"
        case hypoallergenic
        case referenceImageID = "reference_image_id"
        case image
        case catFriendly = "cat_friendly"
        case bidability
    }
}

// MARK: - Image
struct CatImage: Codable {
    let id: String
    let width, height: Int
    let url: String
    
    func parseToDomain() -> CatImageDomainModel {
        return CatImageDomainModel(id: self.id, width: self.width, height: self.height, url: self.url)
    }
}

// MARK: - Weight
struct CatWeightType: Codable {
    let imperial, metric: String
    
    func parseToDomain() -> CatWeightTypeDomainModel {
        return CatWeightTypeDomainModel(imperial: self.imperial, metric: self.metric)
    }
}

extension BreedsResponseDataModel {
    func parseToDomainModel() -> [BreedsResponseDomainModel] {
        self.map({
            .init(weight: $0.catWeight.parseToDomain(),
                                            id: $0.id,
                                            name: $0.name,
                                            cfaURL: $0.cfaURL,
                                            vetstreetURL: $0.vetstreetURL,
                                            vcahospitalsURL: $0.vcahospitalsURL,
                                            temperament: $0.temperament,
                                            origin: $0.origin,
                                            countryCodes: $0.countryCodes,
                                            countryCode: $0.countryCode,
                                            welcomeDescription: $0.welcomeDescription,
                                            lifeSpan: $0.lifeSpan,
                                            indoor: $0.indoor,
                                            lap: $0.lap,
                                            altNames: $0.altNames,
                                            adaptability: $0.adaptability,
                                            affectionLevel: $0.affectionLevel,
                                            childFriendly: $0.childFriendly,
                                            dogFriendly: $0.dogFriendly,
                                            energyLevel: $0.energyLevel,
                                            grooming: $0.grooming,
                                            healthIssues: $0.healthIssues,
                                            intelligence: $0.intelligence,
                                            sheddingLevel: $0.sheddingLevel,
                                            socialNeeds: $0.socialNeeds,
                                            strangerFriendly: $0.strangerFriendly,
                                            vocalisation: $0.vocalisation,
                                            experimental: $0.experimental,
                                            hairless: $0.hairless,
                                            natural: $0.natural,
                                            rare: $0.rare,
                                            rex: $0.rex,
                                            suppressedTail: $0.suppressedTail,
                                            shortLegs: $0.sheddingLevel,
                                            wikipediaURL: $0.wikipediaURL,
                                            hypoallergenic: $0.hypoallergenic,
                                            referenceImageID: $0.referenceImageID,
                                            image: $0.image?.parseToDomain(),
                                            catFriendly: $0.catFriendly,
                  bidability: $0.bidability) }) 
    }
}
