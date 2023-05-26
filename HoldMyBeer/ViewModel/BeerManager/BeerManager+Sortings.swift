//
//  BeerManager+Sortings.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 14.05.23.
//

import Foundation

enum BeerSorting: String, Identifiable, CaseIterable {
    case none = "No sorting"
    case a2z = "A ... Z"
    case z2a = "Z ... A"
    case alcSmall2Large = "alc % vol. small ... large"
    case alcLarge2Small = "alc % vol. large ... small"

    var id: BeerSorting { self }
}

extension BeerManager {
    var sortedBeers: [Beer] {
        switch sorting {
        case .none:
            return beerCatalog
        case .a2z:
            return beerCatalog.sorted { $0.name < $1.name }
        case .z2a:
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
        case .a2z:
            return searchedBeers.sorted { $0.name < $1.name }
        case .z2a:
            return searchedBeers.sorted { $0.name > $1.name }
        case .alcSmall2Large:
            return searchedBeers.sorted { $0.abv < $1.abv }
        case .alcLarge2Small:
            return searchedBeers.sorted { $0.abv > $1.abv }
        }
    }
}
