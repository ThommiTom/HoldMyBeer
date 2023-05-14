//
//  ToBrewsView.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 14.05.23.
//

import SwiftUI

struct ToBrewsView: View {
    @ObservedObject var brewManager: BrewManager
    
    var body: some View {
        NavigationStack {
            Group {
                if brewManager.beers.isEmpty {
                    VStack {
                        Text("No beers to brew!")
                    }
                } else {
                    List {
                        ForEach(brewManager.beers) { beer in
//                            NavigationLink(value: beer) {
//                                BeerListItem(beer: beer)
//                            }
                            BeerListItem(beer: beer)
                        }
                        .onDelete(perform: brewManager.removeBeer)
                        
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("\'To Brews\' (To Dos)")
        }
        .onAppear {
            brewManager.loadBeers()
        }
    }
}

struct ToBrewsView_Previews: PreviewProvider {
    static var previews: some View {
        ToBrewsView(brewManager: BrewManager())
    }
}
