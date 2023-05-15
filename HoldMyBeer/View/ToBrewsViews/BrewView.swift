//
//  BrewView.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 15.05.23.
//

import SwiftUI

struct BrewView: View {
    var brew: Brew
    
    var body: some View {
        List {
            BeerListItem(beer: brew.beer)
            NavigationLink(value: brew.beer) {
                Text("Take a closer look")
            }
            
            Section {
                Text("Show current step in brew process")
                    .bold()
                    .swipeActions {
                        Button {
                            print("will mark this as done and mark first todo as in progress")
                        } label: {
                            Image(systemName: "checkmark.circle")
                        }
                        .tint(.green)
                    }
            } header: {
                Text(ProgressState.inProgress.rawValue)
            } footer: {
                Label("swipe to mark as done", systemImage: "info.circle.fill")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical)

            Section {
                Text("Shows next steps in brew process")
                    .font(.callout)
            } header: {
                Text("NEXT \(ProgressState.toDo.rawValue)")
            }
            .padding(.vertical)

            Section {
                Text("shows last step which has been done")
                    .font(.callout)
                    .opacity(0.7)
            } header: {
                Text(ProgressState.done.rawValue)
            }
            .padding(.vertical)
        }
        .listStyle(.plain)
        .navigationTitle("Brew Progress")
        .navigationDestination(for: Beer.self) { beer in
            BeerDetailView(beer: beer)
        }
    }
}

struct BrewView_Previews: PreviewProvider {
    static var previews: some View {
        BrewView(brew: Brew.example)
    }
}
