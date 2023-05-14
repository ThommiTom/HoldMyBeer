//
//  SearchView.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 14.05.23.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchParameter = SearchParameter()
    var searchBeers: () -> Void
    
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
                    BeerSearchView(searchParameter: $searchParameter)
                case .sommelierView:
                    SommelierView(searchParameter: $searchParameter)
                }
            }
            .navigationTitle(searchParameter.viewTitle)
            
            Spacer()
            
            Button {
                searchBeers()
                dismiss()
            } label: {
                Text(searchParameter.selectedView == .searchView ? "Go for it!" : "Recommend something!")
                    .frame(maxWidth: .infinity)
                    
            }
            .padding()
            .buttonStyle(.borderedProminent)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView {
            print("networkcall here")
        }
    }
}
