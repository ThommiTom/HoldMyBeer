//
//  CommonProperties+Protocol.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 13.05.23.
//

import Foundation

protocol CommonProperties {
    var title: String { get }
    var description: String { get }

    var min: Double { get }
    var max: Double { get }
    var step: Double { get }

    var value: Double { get set }
    var toggle: Bool { get set }
    var inequality: Inequality { get set }
    var setInequality: InequalityParameter { get }
}
