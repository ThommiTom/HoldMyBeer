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
                                .font(.largeTitle)
                                .bold()
                            Text(beer.description)
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
                    .setAlcoholByVolume(.greaterThan, 7)
                    .setBitterness(.lessThan, 50)
                    .setBeerName("ab")
                    .setColorIntesity(.lessThan, 20)
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
                    .setBeerName("Lost dog")
                    .setAlcoholByVolume(.greaterThan, 7)
                    .setBitterness(.lessThan, 50)
                    .buildURL()
                
                if let url = url {
                    print(url.absoluteString)
                    let request = URLRequest(url: url)
                    beerManager.getBeers(request: request)
                }
            }
            .buttonStyle(.bordered)
            
            Button("Network Call 3") {
                beerManager.beers.removeAll()
                let url = URLBuilder.shared
                    .setBeerName("check mate")
                    .buildURL()
                
                if let url = url {
                    print(url.absoluteString)
                    let request = URLRequest(url: url)
                    beerManager.getBeers(request: request)
                }
            }
            .buttonStyle(.bordered)
            
            Button("Network Call 4") {
                beerManager.beers.removeAll()
                let url = URLBuilder.shared
                            .setAlcoholByVolume(.lessThan, 5)
                            .setBitterness(.greaterThan, 36)
                            .setColorIntesity(.greaterThan, 35)
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
