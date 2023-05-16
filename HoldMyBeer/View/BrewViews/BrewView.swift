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
    
    @State private var rateBeer = false
    
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
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                
                ProgressView("Brew Progress", value: brewManager.brews[index].progress, total: 100.0)
                    .tint(brewManager.brews[index].beer.ebc != nil ? EBCScale.getColor(by: brewManager.brews[index].beer.ebc!) : .blue)
                    .padding()
            }
            .padding(.horizontal)
            
            List {
                // next steps
                if let nextStep = brewManager.showNextStep(for: index) {
                    NavigationLink(value: brewManager.brews[index].steps.stepsToDo) {
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Next step")
                                .font(.callout)
                                .foregroundColor(.secondary)
                            Text(nextStep)
                                .font(.callout)
                        }
                    }
                    .padding(.vertical)
                }
                
                // current step
                if brewManager.brews[index].progress < 100.0 {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Current step")
                            .font(.callout)
                            .foregroundColor(.secondary)
                        HStack(spacing: 20) {
                            Image(systemName: "arrow.left")
                            Text("Swipe left to mark as done")
                            Image(systemName: "arrow.left")
                        }
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
                    .padding(.vertical)
                }
                
                // done steps
                if let lastDoneStep = brewManager.showLastDoneStep(for: index) {
                    NavigationLink(value: brewManager.brews[index].steps.doneSteps) {
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Finished steps")
                                .font(.callout)
                                .foregroundColor(.secondary)
                            Text(lastDoneStep)
                                .font(.callout)
                                .opacity(0.7)
                        }
                    }
                    .padding(.vertical)
                }
            }
            .listStyle(.plain)
            
            if brewManager.brews[index].progress == 100.0 && brewManager.brews[index].rating == nil {
                Button {
                    rateBeer = true
                } label: {
                    Text("Drink and rate beer!")
                        .frame(maxWidth: .infinity)
                        
                }
                .padding()
                .buttonStyle(.borderedProminent)
                .padding(.bottom, 50)
            } else if let rating = brewManager.brews[index].rating {
                VStack {
                    StarRatingView(rating: .constant(rating.score))
                        .padding()
                    Text("Comment")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.secondary)
                    Text(rating.comment)
                        .padding()
                    Spacer()
                }
            }
        }
        .navigationTitle("Brew Progress \(brewManager.brews[index].progress, specifier: "%.1f") %")
        .navigationDestination(for: Beer.self) { beer in
            BeerDetailView(beer: beer)
        }
        .navigationDestination(for: [String].self) { instructions in
            InstructionListView(instructions: instructions, viewTitle: "TO DOs")
        }
        .sheet(isPresented: $rateBeer) {
            RatingView(brewManager: brewManager, index: index, beer: brewManager.brews[index].beer)
        }
    }
}


// Preview Does not work du to index and fatal error

//struct BrewView_Previews: PreviewProvider {
//    static var previews: some View {
//        BrewView(brewManager: BrewManager(), index: 0)
//    }
//}
