//
//  BrewManager.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 14.05.23.
//

import Foundation

class BrewManager: ObservableObject {
    @Published private(set) var beers: [Beer] = []
}
