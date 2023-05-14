//
//  BeerManager.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 12.05.23.
//

import Foundation

class BeerManager: ObservableObject {
    @Published private(set) var beerCatalog: [Beer] = []
    @Published private(set) var searchedBeers: [Beer] = []

    @Published var isShowMoreButtonActive = true
    
    private(set) var viewTitle: String = ""
    
    private(set) var pageNo = 1
    let itemsPerPage = 50
    
    func appendCatalog(with beers: [Beer]) {
        beerCatalog.append(contentsOf: beers)
    }
    
    func setSearched(_ beers: [Beer]) {
        searchedBeers = beers
    }
    
    func resetSearchResult() {
        searchedBeers.removeAll()
    }
    
    func incrementPageNo() {
        pageNo += 1
    }
}
