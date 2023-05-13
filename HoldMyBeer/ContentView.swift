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
        VStack {
            HStack {
                Text("🍻")
                    .font(.largeTitle)
                Text("Hold My Beer")
                Text("🍻")
                    .font(.largeTitle)
            }
            
            Spacer()
            
            if beerManager.beers.isEmpty {
                VStack {
                    Text("Currently no beers available")
                }
            } else {
                List {
                    ForEach(beerManager.beers) { beer in
                        VStack(alignment: .leading) {
                            Text(beer.name)
                                .font(.title)
                                .bold()
                            Text(beer.tagline)
                                .font(.callout)
                        }
                    }
                }
                .listStyle(.plain)
            }
            
            Spacer()
            
            Button("Network Call 1") {
                beerManager.beers.removeAll()
                let url = URLBuilder.shared
                    .addQueryItem(for: .alcoholByVolumeGreaterThan, 7.1)
                    .addQueryItem(for: .bitternessLessThan, 50.0)
                    .addFuzzyQueryItem(for: .beerName, "ab")
                    .addQueryItem(for: .beerColorBrighterThan, 20)
                    .addFuzzyQueryItem(for: .brewedBefore, "08-2011")
                    .buildURL()
                
                if let url = url {
                    print(url.absoluteString)
                    let request = URLRequest(url: url)
                    beerManager.getBeers(request: request)
                } else {
                    print("Oops something went wrong..")
                }
                
            }
            .buttonStyle(.bordered)
            
            Button("Network Call 2") {
                beerManager.beers.removeAll()
                let url = URLBuilder.shared
                    .addQueryItem(for: .alcoholByVolumeGreaterThan, 7.1)
                    .addQueryItem(for: .bitternessLessThan, 50.0)
                    .addFuzzyQueryItem(for: .beerName, "ab")
                    .addQueryItem(for: .beerColorBrighterThan, 20)
                    .addQueryItem(for: .alcoholByVolumeLessThan, 5)
                    .addQueryItem(for: .bitternessGreaterThan, 45.0)
                    .addFuzzyQueryItem(for: .beerName, "dog")
                    .addQueryItem(for: .beerColorDarkerThan, 22)
                    .buildURL()
                
                if let url = url {
                    print(url.absoluteString)
                    let request = URLRequest(url: url)
                    beerManager.getBeers(request: request)
                } else {
                    print("Oops something went wrong..")
                }
                
            }
            .buttonStyle(.bordered)
            
            Button("Network Call 3") {
                beerManager.beers.removeAll()
                let url = URLBuilder.shared
                    .addFuzzyQueryItem(for: .beerName, "Lost dog")
                    .addQueryItem(for: .alcoholByVolumeGreaterThan, 7)
                    .addQueryItem(for: .bitternessLessThan, 50.5)
                    .buildURL()
                
                if let url = url {
                    print(url.absoluteString)
                    let request = URLRequest(url: url)
                    beerManager.getBeers(request: request)
                }
            }
            .buttonStyle(.bordered)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
