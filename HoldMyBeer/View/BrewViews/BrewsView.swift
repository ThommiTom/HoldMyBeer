//
//  BrewsView.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 14.05.23.
//

import SwiftUI

struct BrewsView: View {
    @StateObject var brewManager = BrewManager()
    
    var body: some View {
        NavigationStack {
            Group {
                if brewManager.brews.isEmpty {
                    EmptyBrewView()
                } else {
                    List {
                        ForEach(brewManager.brews) { brew in
                            NavigationLink(value: brew) {
                                BrewListItem(brew: brew)
                            }
                        }
                        .onDelete(perform: brewManager.removeBrew)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Brews")
            .navigationDestination(for: Brew.self) { brew in
                BrewView(brewManager: brewManager, index: brewManager.getIndexOf(brew.beer))
            }
        }
        .onAppear {
            brewManager.load()
        }
    }
}

struct BrewsView_Previews: PreviewProvider {
    static var previews: some View {
        BrewsView(brewManager: BrewManager())
    }
}
