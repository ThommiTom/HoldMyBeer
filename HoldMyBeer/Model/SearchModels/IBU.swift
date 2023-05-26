//
//  IBU.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 13.05.23.
//

import Foundation

struct IBU: CommonProperties {
    let title = "IBU"
    let description =
    """

    International Bitterness Unit attempt to rate
    the relative bitterness of beer.
    The bitterness of beer is provided by compounds such as humulones,
    or alpha acids from hops used during brewing.
    """

    let min = 0.0
    let max = 120.0
    let step = 0.1

    var value: Double = 25.0
    var toggle = false

    var inequality: Inequality = .greaterThan
    var setInequality: InequalityParameter {
        switch inequality {
        case .greaterThan:
            return .bitternessGreaterThan
        case .lessThan:
            return .bitternessLessThan
        }
    }
}
