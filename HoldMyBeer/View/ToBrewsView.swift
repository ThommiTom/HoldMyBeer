//
//  ToBrewsView.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 14.05.23.
//

import SwiftUI

struct ToBrewsView: View {
    
    var body: some View {
        NavigationStack {
            Text("TODO")
                .navigationTitle("\"To Brews\" (To Dos)")
        }
        .onAppear {
            // TODO: load to brews beers
        }
    }
}

struct ToBrewsView_Previews: PreviewProvider {
    static var previews: some View {
        ToBrewsView()
    }
}
