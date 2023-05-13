//
//  EBC.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 13.05.23.
//

import Foundation

struct EBC: CommonProperties {
    let title = "EBC"
    let description = "European Brewery Convention describes the color strength of beer in Europe.\nThe color number defined by the European Brewery Convention is determined photometrically from a standardized mash."
    
    let min = 0.0
    let max = 40.0
    let step = 0.1
    
    var value: Double = 8.0
    var toggle = false
    
    var inequality: Inequality = .greaterThan
    var setInequality: InequalityParameter {
        switch inequality {
        case .greaterThan:
            return .beerColorDarkerThan
        case .lessThan:
            return .beerColorBrighterThan
        }
    }
}
