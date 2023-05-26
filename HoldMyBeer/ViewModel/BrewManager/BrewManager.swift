//
//  BrewManager.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 14.05.23.
//

import Foundation

class BrewManager: ObservableObject {
    @Published private(set) var brews = [Brew]()

    private var beers =  [Beer]()

    init() {
        load()
    }

    var currentStep: String {
        return ""
    }

    func load() {
        loadBeers()
        loadBrews()
        updateBrewsWithNewBeers()
        saveBrew()
    }

    private func loadBeers() {
        beers =  Persistence.shared.loadBeersToBrew()
    }

    private func loadBrews() {
        brews = Persistence.shared.loadBrews()
    }

    func updateBrewsWithNewBeers() {
        for beer in beers where !brews.contains(where: { $0.id == beer.id }) {
            brews.append(Brew(beer: beer, steps: self.setBrewInstructionsMockUp()))
        }
    }

    func saveBeers() {
        Persistence.shared.saveBeersToBrew(beers)
    }

    func saveBrew() {
        Persistence.shared.saveBrews(brews)
    }

    func removeBeer(at offsets: IndexSet) {
        beers.remove(atOffsets: offsets)
        saveBeers()
    }

    func removeBrew(at offsets: IndexSet) {
        brews.remove(atOffsets: offsets)
        saveBrew()
        removeBeer(at: offsets)
    }

    func getIndexOf(_ beer: Beer) -> Int {
        if let index = brews.firstIndex(where: { $0.id == beer.id }) {
            return index
        }

        // should never happen, unless there is a fundamental bug
        fatalError("[FATAL ERROR] index out of bound!")
    }

    func nextStepForBrew(with index: Int) {
        if !brews[index].steps.stepsToDo.step.isEmpty {
            // we have some step to do
            brews[index].steps.doneSteps.step.append(brews[index].steps.currentStep)
            brews[index].steps.currentStep = brews[index].steps.stepsToDo.step.first!
            brews[index].steps.stepsToDo.step.removeFirst()
        } else if !brews[index].steps.currentStep.isEmpty {
            brews[index].steps.doneSteps.step.append(brews[index].steps.currentStep)
            brews[index].steps.currentStep = ""
        }

        saveBrew()
    }

    func showCurrnetStep(for index: Int) -> String {
        return brews[index].steps.currentStep
    }

    func showNextStep(for index: Int) -> String? {
        return brews[index].steps.stepsToDo.step.first
    }

    func showLastDoneStep(for index: Int) -> String? {
        return brews[index].steps.doneSteps.step.last
    }

    func saveRating(_ rating: Rating, for index: Int) {
        brews[index].rating = rating
        saveBrew()
    }
}
