//
//  RatedBrewsView.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 14.05.23.
//

import SwiftUI

struct RatedBrewsView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                Text("No beers rated so far!")
                    .font(.largeTitle)
                    .bold()
                Text("Brew beer! Drink beer! Rate beer!")
                    .font(.callout)
                    .foregroundColor(.secondary)
            }
            .navigationTitle("Rated Brews")
        }
        .onAppear {
            // TODO: load to brews beers
        }
    }
}

struct RatedBrewsView_Previews: PreviewProvider {
    static var previews: some View {
        RatedBrewsView()
    }
}
