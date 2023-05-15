//
//  BrewView.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 15.05.23.
//

import SwiftUI

struct BrewView: View {
    @ObservedObject var brewManager: BrewManager
    var index: Int
    
    var body: some View {
        VStack {
            Group {
                NavigationLink(value: brewManager.brews[index].beer) {
                    HStack {
                        BeerListItem(beer: brewManager.brews[index].beer)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                }
                .buttonStyle(.plain)
                
                ProgressView("Brew Progress", value: brewManager.brews[index].progress, total: 100.0)
                    .tint(brewManager.brews[index].beer.ebc != nil ? EBCScale.getColor(by: brewManager.brews[index].beer.ebc!) : .blue)
                    .padding()
            }
            .padding(.horizontal)
            
            List {
                // current step
                Section {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Swipe left to mark as done")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.green)
                        Text(brewManager.showCurrnetStep(for: index))
                            .bold()
                    }
                    .swipeActions {
                        Button {
                            brewManager.nextStepForBrew(with: index)
                        } label: {
                            Image(systemName: "checkmark.circle")
                        }
                        .tint(.green)
                    }
                } header: {
                    Text("Current Step")
                }
                
                .padding(.vertical)

                // next steps
                if let nextStep = brewManager.showNextStep(for: index) {
                    Section {
                        Text(nextStep)
                            .font(.callout)
                    } header: {
                        Text("Next Step")
                    }
                    .padding(.vertical)
                }
                
                // done steps
                if let lastDoneStep = brewManager.showLastDoneStep(for: index) {
                    Section {
                        Text(lastDoneStep)
                            .font(.callout)
                            .opacity(0.7)
                    } header: {
                        Text("finished steps")
                    }
                    .padding(.vertical)
                }
                
            }
            .listStyle(.plain)
        }
        .navigationTitle("Brew Progress \(brewManager.brews[index].progress, specifier: "%.1f") %")
        .navigationDestination(for: Beer.self) { beer in
            BeerDetailView(beer: beer)
        }
    }
}


// Preview Does not work du to index and fatal error

//struct BrewView_Previews: PreviewProvider {
//    static var previews: some View {
//        BrewView(brewManager: BrewManager(), index: 0)
//    }
//}
