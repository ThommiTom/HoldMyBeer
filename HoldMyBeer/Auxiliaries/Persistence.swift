//
//  Persistence.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 14.05.23.
//

import Foundation

class Persistence {
    static let shared = Persistence()
    
    private init() {
        self.savedBeersToBrew = self.loadBeersToBrew()
    }
    
    
    fileprivate let beersToBrewPath = FileManager.documentDirectory.appendingPathComponent("beerToBrew")
    private var savedBeersToBrew = [Beer]()
    
    fileprivate let brewsPath = FileManager.documentDirectory.appendingPathComponent("brews")
    
    
    // MARK: funcs for beers to brew
    func saveBeersToBrew(_ beer: Beer) {
        if !savedBeersToBrew.contains(where: { $0.id == beer.id }) {
            savedBeersToBrew.append(beer)
            FileManager().save(item: savedBeersToBrew, location: beersToBrewPath)
        }
    }
    
    func saveBeersToBrew(_ beers: [Beer]) {
        savedBeersToBrew = beers
        FileManager().save(item: savedBeersToBrew, location: beersToBrewPath)
    }
    
    func loadBeersToBrew() -> [Beer] {
        if let loadedBeersToBrew: [Beer] = FileManager().load(location: beersToBrewPath) {
            return loadedBeersToBrew
        }
        
        return [Beer]()
    }
    
    
    // MARK: funcs for brews
    func saveBrews(_ brews: [Brew]) {
        FileManager().save(item: brews, location: brewsPath)
    }
    
    func loadBrews() -> [Brew] {
        if let loadedBrews: [Brew] = FileManager().load(location: brewsPath) {
            return loadedBrews
        }
        return [Brew]()
    }
}
