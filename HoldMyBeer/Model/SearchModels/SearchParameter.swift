//
//  SearchCriteria.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 13.05.23.
//

import Foundation

struct SearchParameter {
    var beerName: String = ""
    
    var toggleBrewDate: Bool = false
    var inequalitySelection = Inequality.greaterThan
    
    let pickerMonth = Array<Int>.init(1...12)
    var monthSelection = 6
    let pickerYear = Array<Int>.init(2003...2023)
    var pickerYearAsString: Array<String> {
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
        case .greaterThan:
            return .brewedAfter
        case .lessThan:
            return .brewedBefore
        }
    }
    
    var foodPairing: String = ""
    
    var yeast: String = ""
    var hops: String = ""
    var malt: String = ""
    
    let pickerChoice = [Inequality.greaterThan, Inequality.lessThan]
}

enum Inequality: String {
    case greaterThan = ">"
    case lessThan = "<"
}



