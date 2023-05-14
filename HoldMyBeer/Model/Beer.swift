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
    let targetFg: Int?
    let targetOg: Double?
    let ebc: Double?
    let srm, ph: Double?
    let attenuationLevel: Double?

//    let ingredients: Ingredients?
    let foodPairing: [String]?
    let brewersTips: String?

//    let volume: BoilVolume?
//    let boilVolume: BoilVolume?
//    let method: Met?
//    let metod: Met?
    
    static let example = Beer(id: 1,
                              name: "Buzz",
                              tagline: "A Real Bitter Experience.",
                              first_brewed: "09/2007",
                              description: "A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.",
                              image_url: "https://images.punkapi.com/v2/keg.png",
                              abv: 4.5,
                              ibu: nil, targetFg: nil, targetOg: nil, ebc: nil, srm: nil, ph: nil, attenuationLevel: nil, foodPairing: nil, brewersTips: nil)
}

struct BoilVolume: Codable, Hashable {
    let value: Double
    let unit: Unit
}

enum Unit: Codable, Hashable {
    case celsius
    case grams
    case kilograms
    case litres
}

struct Ingredients: Codable, Hashable {
    let malt: [Malt]
    let hops: [Hop]
    let yeast: String
}

struct Hop: Codable, Hashable {
    let name: String
    let amount: BoilVolume
    let add: Add
    let attribute: Attribute
}

enum Add: Codable {
    case dryHop
    case end
    case middle
    case start
}

enum Attribute: Codable {
    case aroma
    case attributeFlavour
    case bitter
    case flavour
}

struct Malt: Codable, Hashable {
    let name: String
    let amount: BoilVolume
}

struct Met: Codable, Hashable {
    let mashTemp: [MashTemp]
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
