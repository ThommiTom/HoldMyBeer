//
//  SearchParameter.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 13.05.23.
//

import Foundation

struct SearchParameter {
    var selectedView: SearchViewOptions = .searchView

    var viewTitle: String {
        switch selectedView {
        case .searchView:
            return "Search Parameter"
        case .sommelierView:
            return "Recommendation"
        }
    }

    var beerName: String = ""

    var toggleBrewDate: Bool = false
    var inequalitySelection = TimeInequality.brewedAfter

    let pickerMonth = 1...12
    var monthSelection = 6
    let pickerYear = 2003...2023
    var pickerYearAsString: [String] {
        var array = [String]()
        for year in pickerYear {
            array.append(String(year))
        }
        return array
    }
    var yearSelection = "2013"

    var brewDate: String {
        if monthSelection < 10 {
            return "0\(monthSelection)-\(yearSelection)"
        } else {
            return "\(monthSelection)-\(yearSelection)"
        }
    }

    var setInequality: InequalityParameter {
        switch inequalitySelection {
        case .brewedAfter:
            return .brewedAfter
        case .brewedBefore:
            return .brewedBefore
        }
    }

    var foodPairing: String = ""

    var yeast: String = ""
    var hops: String = ""
    var malt: String = ""

    let inequalityChoice: [TimeInequality] = [.brewedAfter, .brewedBefore]
    let viewChoices: [SearchViewOptions] = [.searchView, .sommelierView]
}

enum TimeInequality: String, Identifiable {
    case brewedBefore = "before"
    case brewedAfter = "after"

    var id: TimeInequality { self }
}

enum SearchViewOptions: String, Identifiable {
    case searchView = "Search"
    case sommelierView = "Sommelier"

    var id: SearchViewOptions { self }
}
