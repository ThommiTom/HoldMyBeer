//
//  SearchView.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 14.05.23.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var beerManager: BeerManager
    @State private var searchParameter = SearchParameter()
    
    var body: some View {
        NavigationStack {
            Picker("View Selection", selection: $searchParameter.selectedView) {
                ForEach(searchParameter.viewChoices) { Text($0.rawValue)}
            }
            .pickerStyle(.segmented)
            .padding()
            
            Group {
                switch searchParameter.selectedView {
                case .searchView:
                    BeerSearchView(searchParameter: $searchParameter) {
                        beerManager.searchBeers()
                    }
                case .sommelierView:
                    SommelierView(searchParameter: $searchParameter) {
                        beerManager.searchBeers()
                    }
                }
            }
            .navigationTitle(searchParameter.viewTitle)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(beerManager: BeerManager())
    }
}
