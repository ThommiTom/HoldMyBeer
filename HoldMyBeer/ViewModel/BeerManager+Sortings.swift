//
//  BeerManager+Sortings.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 14.05.23.
//

import Foundation

enum BeerSorting: String, Identifiable, CaseIterable {
    case none = "No sorting"
    case A2Z = "A ... Z"
    case Z2A = "Z ... A"
    case alcSmall2Large = "alc % vol. small ... large"
    case alcLarge2Small = "alc % vol. large ... small"
    
    var id: BeerSorting { self }
}

extension BeerManager {
    var sortedBeers: [Beer] {
        switch sorting {
        case .none:
            return beerCatalog
        case .A2Z:
            return beerCatalog.sorted { $0.name < $1.name }
        case .Z2A:
            return beerCatalog.sorted { $0.name > $1.name }
        case .alcSmall2Large:
            return beerCatalog.sorted { $0.abv < $1.abv }
        case .alcLarge2Small:
            return beerCatalog.sorted { $0.abv > $1.abv }
        }
    }
    
    var sortedSearchedBeers: [Beer] {
        switch sorting {
        case .none:
            return searchedBeers
        case .A2Z:
            return searchedBeers.sorted { $0.name < $1.name }
        case .Z2A:
            return searchedBeers.sorted { $0.name > $1.name }
        case .alcSmall2Large:
            return searchedBeers.sorted { $0.abv < $1.abv }
        case .alcLarge2Small:
            return searchedBeers.sorted { $0.abv > $1.abv }
        }
    }
}
