//
//  BrewManager.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 14.05.23.
//

import Foundation

class BrewManager: ObservableObject {
    @Published private(set) var beers =  [Beer]()
    
    init() {
        self.loadBeers()
    }
    
    func saveBeers() {
        Persistence.shared.saveBeersToBrew(beers)
    }
    
    func loadBeers() {
        self.beers =  Persistence.shared.loadBeersToBrew()
    }
    
    func removeBeer(at offsets: IndexSet) {
        beers.remove(atOffsets: offsets)
        saveBeers()
    }
}
