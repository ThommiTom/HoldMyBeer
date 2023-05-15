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
                if brewManager.brews.isEmpty {
                    EmptyBrewView()
                } else {
                    List {
                        ForEach(brewManager.brews) { brew in
                            NavigationLink(value: brew) {
                                BeerListItem(beer: brew.beer)
                            }
                        }
                        .onDelete(perform: brewManager.removeBrew)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("\'To Brews\' (To Dos)")
            .navigationDestination(for: Brew.self) { brew in
                BrewView(brewManager: brewManager, index: brewManager.getIndexOf(brew.beer))
            }
        }
        .onAppear {
            brewManager.load()
        }
    }
}

struct ToBrewsView_Previews: PreviewProvider {
    static var previews: some View {
        ToBrewsView(brewManager: BrewManager())
    }
}
