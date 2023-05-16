//
//  ContentView.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 12.05.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            BeerCatalogView()
                .tabItem {
                    Image(systemName: "list.clipboard")
                    Text("Beers")
                }
            
            BrewsView()
            .tabItem {
                Image(systemName: "checklist")
                Text("Brews")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
