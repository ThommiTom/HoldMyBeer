//
//  Beer.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 12.05.23.
//

struct Beer: Identifiable, Codable, Hashable {
    let id: Int
    let name: String
    let tagline: String
    let first_brewed: String?
    let description: String
    let image_url: String?
    let abv: Double
    let ibu: Double?
    let target_fg: Int?
    let target_og: Double?
    let ebc: Double?
    let srm, ph: Double?
    let attenuationLevel: Double?

    let ingredients: Ingredients?
    let food_pairing: [String]
    let brewers_tips: String?

    let volume: BoilVolume?
    let boilVolume: BoilVolume?
    let method: Met?
    let metod: Met?
    
    static let example = Beer(id: 1,
                              name: "Buzz",
                              tagline: "A Real Bitter Experience.",
                              first_brewed: "09/2007",
                              description: "A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.",
                              image_url: "https://images.punkapi.com/v2/keg.png",
                              abv: 4.5,
                              ibu: nil,
                              target_fg: nil,
                              target_og: nil,
                              ebc: nil,
                              srm: nil,
                              ph: nil,
                              attenuationLevel: nil,
                              ingredients: nil,
                              food_pairing: [String](),
                              brewers_tips: nil,
                              volume: nil,
                              boilVolume: nil,
                              method: nil,
                              metod: nil)
}

struct BoilVolume: Codable, Hashable {
    let value: Double?
    let unit: String
}

struct Ingredients: Codable, Hashable {
    let malt: [Malt]
    let hops: [Hop]
    let yeast: String?
}

struct Hop: Codable, Hashable {
    let name: String
    let amount: BoilVolume
    let add: String
    let attribute: String
}

struct Malt: Codable, Hashable {
    let name: String
    let amount: BoilVolume
}

struct Met: Codable, Hashable {
    let mash_temp: [MashTemp]
    let fermentation: Fermentation
    let twist: String?
}

struct Fermentation: Codable, Hashable {
    let temp: BoilVolume
}

struct MashTemp: Codable, Hashable {
    let temp: BoilVolume
    let duration: Int?
}
