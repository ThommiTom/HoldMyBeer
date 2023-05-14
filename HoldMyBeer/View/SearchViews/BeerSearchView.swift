//
//  BeerSearch.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 13.05.23.
//

import SwiftUI

struct BeerSearchView: View {
    @Binding var searchParameter: SearchParameter
    
    var body: some View {
        VStack {
            List {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Search for...")
                    TextField("Beer Name", text: $searchParameter.beerName)
                        .onChange(of: searchParameter.beerName) { newValue in
                            if newValue.isEmpty {
                                let _ = URLBuilder.shared.removeFuzzyQueryItem(for: .beerName)
                            } else {
                                let _ = URLBuilder.shared.addFuzzyQueryItem(for: .beerName, newValue)
                            }
                        }
                }
                .padding()
                
                VStack {
                    Toggle("Brew Date", isOn: $searchParameter.toggleBrewDate)
                        .onChange(of: searchParameter.toggleBrewDate) { newValue in
                            if newValue {
                                let _ = URLBuilder.shared.addQueryItem(for: searchParameter.setInequality, searchParameter.brewDate)
                            } else {
                                let _ = URLBuilder.shared.removeQueryItem(for: searchParameter.setInequality)
                            }
                        }
                    if searchParameter.toggleBrewDate {
                        GeometryReader { geometry in
                            HStack {
                                Picker("Inequality", selection: $searchParameter.inequalitySelection) {
                                    ForEach(searchParameter.inequalityChoice) { Text($0.rawValue) }
                                }
                                .labelsHidden()
                                .frame(maxWidth: geometry.size.width / 3)
                                .pickerStyle(.wheel)
                                .onChange(of: searchParameter.inequalitySelection) { _ in
                                    let _ = URLBuilder.shared.addQueryItem(for: searchParameter.setInequality, searchParameter.brewDate)
                                }
                                
                                Picker("Month", selection: $searchParameter.monthSelection) {
                                    ForEach(searchParameter.pickerMonth, id: \.self) { Text("\($0)") }
                                }
                                .labelsHidden()
                                .frame(maxWidth: geometry.size.width / 3)
                                .pickerStyle(.wheel)
                                .onChange(of: searchParameter.monthSelection) { _ in
                                    let _ = URLBuilder.shared.addQueryItem(for: searchParameter.setInequality, searchParameter.brewDate)
                                }
                                
                                Picker("Year", selection: $searchParameter.yearSelection) {
                                    ForEach(searchParameter.pickerYearAsString, id: \.self) { Text($0) }
                                }
                                .labelsHidden()
                                .frame(maxWidth: geometry.size.width / 3)
                                .pickerStyle(.wheel)
                                .onChange(of: searchParameter.yearSelection) { _ in
                                    let _ = URLBuilder.shared.addQueryItem(for: searchParameter.setInequality, searchParameter.brewDate)
                                }
                            }
                        }
                        .frame(minHeight: 90)
                    }
                }
                
                CommonPropertiesView(common: ABV())
                CommonPropertiesView(common: IBU())
                CommonPropertiesView(common: EBC())
            }
            .listStyle(.plain)
        }
        .onAppear {
            URLBuilder.shared.resetQueryItems()
        }
    }
}

struct BeerSearchView_Previews: PreviewProvider {
    static var previews: some View {
        BeerSearchView(searchParameter: Binding<SearchParameter>.constant(SearchParameter()))
    }
}
