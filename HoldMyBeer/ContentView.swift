//
//  ContentView.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 12.05.23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var beerManager = BeerManager()
    @StateObject var brewManager = BrewManager()
    
    var body: some View {
        TabView {
            AssortmentView(beerManager: beerManager)
                .tabItem {
                    Image(systemName: "list.clipboard")
                    Text("Assortment")
                }
            
            ToBrewsView(brewManager: brewManager)
            .tabItem {
                Image(systemName: "checklist")
                Text("\'To Brews\'")
            }
            
            RatedBrewsView()
            .tabItem {
                Image(systemName: "star")
                Text("Rated Brews")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
