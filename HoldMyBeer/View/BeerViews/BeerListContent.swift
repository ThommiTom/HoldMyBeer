//
//  BeerList.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 27.05.23.
//

import SwiftUI

struct BeerListContent: View {
    @ObservedObject var beerManager: BeerManager
    let beers: [Beer]

    var body: some View {
        ForEach(beers) { beer in
            NavigationLink(value: beer) {
                BeerListItem(beer: beer, containedInToBrew: beerManager.containedInBrews(id: beer.id))
                    .swipeActions(edge: .leading, allowsFullSwipe: false) {
                        if !beerManager.beersToBrew.contains(beer.id) {
                            Button {
                                beerManager.addToBrews(id: beer.id)
                                beerManager.saveBeerToBrews(beer)
                            } label: {
                                Label("Add to Brews", systemImage: "checklist")
                            }
                            .tint(.blue)
                        }
                    }
            }
        }
    }
}

struct BeerList_Previews: PreviewProvider {
    static var previews: some View {
        BeerListContent(beerManager: BeerManager(), beers: [Beer]())
    }
}
