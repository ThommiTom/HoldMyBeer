//
//  EmptyBrewView.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 15.05.23.
//

import SwiftUI

struct EmptyBrewView: View {
    var body: some View {
        VStack(spacing: 25) {
            Text("No beers to brew!")
                .font(.largeTitle)
                .bold()
            Text("Add beers via Assortment Tab by swiping.")
                .font(.callout)
                .foregroundColor(.secondary)
        }
    }
}

struct EmptyBrewView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyBrewView()
    }
}
