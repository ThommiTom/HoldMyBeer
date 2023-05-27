//
//  ContentView.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 12.05.23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var beerManager = BeerManager()

    var body: some View {
        TabView {
            BeerCatalogView(beerManager: beerManager)
                .tabItem {
                    Image(systemName: "list.clipboard")
                    Text("Beers")
                }

            BrewListView()
            .tabItem {
                Image(systemName: "checklist")
                Text("Brews")
            }
            .onAppear {
                beerManager.resetPath()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
