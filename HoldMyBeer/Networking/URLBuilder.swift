//
//  URLBuilder.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 12.05.23.
//

import Foundation

class URLBuilder {
    static let shared = URLBuilder()
    
    private init() {
        urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.punkapi.com"
        urlComponents.path = "/v2/beers"
        
        queryItems = []
    }
    
    private var urlComponents: URLComponents
    private var queryItems: [URLQueryItem]
    
//    private func findItemIndex(for criteria: [String]) -> Int? {
//        if let index = queryItems.firstIndex(where: { $0.name ==  }) {
//            queryItems[index] = newItem
//        } else if let index = queryItems.firstIndex(where: { $0.name == "abv_lt" }) {
//            queryItems[index] = newItem
//        } else {
//            queryItems.append(newItem)
//        }
//    }
    
    // ABV - Alcohol by Volume
    func setAlcoholByVolume(_ criteria: Inequality, _ percentage: Int) -> URLBuilder {
        var param: String
        
        switch criteria {
        case .greaterThan:
            param = "abv_gt"
        case .lessThan:
            param = "abv_lt"
        }
        
        let newItem = URLQueryItem(name: param, value: String(percentage))
        
        if let index = queryItems.firstIndex(where: { $0.name == "abv_gt" }) {
            queryItems[index] = newItem
        } else if let index = queryItems.firstIndex(where: { $0.name == "abv_lt" }) {
            queryItems[index] = newItem
        } else {
            queryItems.append(newItem)
        }
        
        return self
    }
    
    // IBU - International Bitterness Unit
    func setBitterness(_ criteria: Inequality, _ value: Int) -> URLBuilder {
        var param: String
        
        switch criteria {
        case .greaterThan:
            param = "ibu_gt"
        case .lessThan:
            param = "ibu_lt"
        }
        
        let newItem = URLQueryItem(name: param, value: String(value))
        
        if let index = queryItems.firstIndex(where: { $0.name == "ibu_gt" }) {
            queryItems[index] = newItem
        } else if let index = queryItems.firstIndex(where: { $0.name == "ibu_lt" }) {
            queryItems[index] = newItem
        } else {
            queryItems.append(newItem)
        }
        
        return self
    }
    
    // EBC - Estimating Beer Color
    func setColorIntesity(_ criteria: Inequality, _ value: Int) -> URLBuilder {
        var param: String
        
        switch criteria {
        case .greaterThan:
            param = "ebc_gt"
        case .lessThan:
            param = "ebc_gt"
        }
        
        let newItem = URLQueryItem(name: param, value: String(value))
        
        if let index = queryItems.firstIndex(where: { $0.name == "ebc_gt" }) {
            queryItems[index] = newItem
        } else if let index = queryItems.firstIndex(where: { $0.name == "ebc_gt" }) {
            queryItems[index] = newItem
        } else {
            queryItems.append(newItem)
        }
        
        return self
    }
    
    // setting a particular name
    func setBeerName(_ name: String) -> URLBuilder {
        let modifiedName = name.replacingOccurrences(of: " ", with: "_").lowercased()
        
        
        let newItem = URLQueryItem(name: "beer_name", value: modifiedName)
        
        if let index = queryItems.firstIndex(where: { $0.name == "beer_name" }) {
            queryItems[index] = newItem
        } else {
            queryItems.append(newItem)
        }
        
        return self
    }
    
    #warning("continue with implementation of further params!")
    
    func buildURL() -> URL? {
        urlComponents.queryItems = queryItems
        let url = urlComponents.url
        queryItems.removeAll()
        
        return url
    }
    
}

enum Inequality {
    case greaterThan
    case lessThan
}

enum TimeSpan {
    case brewedBefore
    case brewedAfter
}
