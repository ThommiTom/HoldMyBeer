//
//  BrewManager.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 14.05.23.
//

import Foundation

class BrewManager: ObservableObject {
    @Published private(set) var brews = [Brew]()
    
    private var beers =  [Beer]()
    
    init() {
        load()
    }
    
    func load() {
        loadBeers()
        loadBrews()
        for beer in beers {
            if !brews.contains(where: { $0.id == beer.id }) {
                brews.append(Brew(beer: beer, process: [Instruction]()))
            }
        }
        saveBrew()
    }
    
    func saveBrew() {
        Persistence.shared.saveBrews(brews)
    }
    
    private func loadBrews() {
        brews = Persistence.shared.loadBrews()
    }
    
    func saveBeers() {
        Persistence.shared.saveBeersToBrew(beers)
    }
    
    private func loadBeers() {
        beers =  Persistence.shared.loadBeersToBrew()
    }
    
    func removeBrew(at offsets: IndexSet) {
        brews.remove(atOffsets: offsets)
        saveBrew()
        removeBeer(at: offsets)
    }
    
    func removeBeer(at offsets: IndexSet) {
        beers.remove(atOffsets: offsets)
        saveBeers()
    }
}
