//
//  ABV.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 13.05.23.
//

import Foundation

struct ABV: CommonProperties {
    let title = "ABV"
    let description = "Alcohol by volume (abbreviated as ABV, abv, or alc/vol) is a standard measure of how much alcohol (ethanol) is contained in a given volume of an alcoholic beverage (expressed as a volume percent)."
    
    let min = 0.0
    let max = 13.0
    let step = 0.1
    
    var value: Double = 6
    var toggle = false
    
    var inequality: Inequality = .greaterThan
    var setInequality: InequalityParameter {
        switch inequality {
        case .greaterThan:
            return .alcoholByVolumeGreaterThan
        case .lessThan:
            return .alcoholByVolumeLessThan
        }
    }
}


