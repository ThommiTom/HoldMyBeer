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
    
    
    func addQueryItem(for param: InequalityParameter, _ value: Double) -> URLBuilder {
        let newQueryItem = URLQueryItem(name: param.rawValue, value: String(value))
        let opposite = opposites[param]!
        
        if let index = queryItems.firstIndex(where: { $0.name == param.rawValue }) {
            queryItems[index] = newQueryItem
        } else if let index = queryItems.firstIndex(where: { $0.name == opposite.rawValue }) {
            queryItems[index] = newQueryItem
        } else {
            queryItems.append(newQueryItem)
        }
        
        return self
    }
    
    func addQueryItem(for param: InequalityParameter, _ value: String) -> URLBuilder {
        let newQueryItem = URLQueryItem(name: param.rawValue, value: value)
        let opposite = opposites[param]!
        
        if let index = queryItems.firstIndex(where: { $0.name == param.rawValue }) {
            queryItems[index] = newQueryItem
        } else if let index = queryItems.firstIndex(where: { $0.name == opposite.rawValue }) {
            queryItems[index] = newQueryItem
        } else {
            queryItems.append(newQueryItem)
        }
        
        return self
    }
    
    func removeQueryItem(for param: InequalityParameter) -> URLBuilder {
        if let index = queryItems.firstIndex(where: { $0.name == param.rawValue }) {
            queryItems.remove(at: index)
        }
        
        return self
    }
    
    func addFuzzyQueryItem(for param: FuzzyParameter, _ name: String) -> URLBuilder {
        let modifiedName = name.replacingOccurrences(of: " ", with: "_").lowercased()
        
        let newItem = URLQueryItem(name: param.rawValue, value: modifiedName)
        
        if let index = queryItems.firstIndex(where: { $0.name == param.rawValue }) {
            queryItems[index] = newItem
        } else {
            queryItems.append(newItem)
        }
        
        return self
    }
    
    func removeFuzzyQueryItem(for param: FuzzyParameter) -> URLBuilder {
        if let index = queryItems.firstIndex(where: { $0.name == param.rawValue }) {
            queryItems.remove(at: index)
        }
        
        return self
    }
    
    // provides the constructed URL
    func buildURL() -> URL? {
        urlComponents.queryItems = queryItems
        let url = urlComponents.url
        queryItems.removeAll()
        
        return url
    }
    
    func resetQueryItems() {
        queryItems.removeAll()
    }
    
    func createPaginationURL(page: Int, itemsPerPage: Int) -> URL? {
        urlComponents.queryItems = [ URLQueryItem(name: "page", value: String(page)), URLQueryItem(name: "per_page", value: String(itemsPerPage))]
        let url = urlComponents.url
        
        return url
    }
    
}

enum Inequality: String, Identifiable {
    case greaterThan = ">"
    case lessThan = "<"
    
    var id: Inequality { self }
}

enum InequalityParameter: String {
    case alcoholByVolumeGreaterThan = "abv_gt"
    case alcoholByVolumeLessThan = "abv_lt"
    case bitternessGreaterThan = "ibu_gt"
    case bitternessLessThan = "ibu_lt"
    case beerColorDarkerThan = "ebc_gt"
    case beerColorBrighterThan = "ebc_lt"
    case brewedBefore = "brewed_before"
    case brewedAfter = "brewed_after"
}

fileprivate let opposites: Dictionary<InequalityParameter, InequalityParameter> = [
    .alcoholByVolumeGreaterThan : .alcoholByVolumeLessThan,
    .alcoholByVolumeLessThan : .alcoholByVolumeGreaterThan,
    .bitternessGreaterThan : .bitternessLessThan,
    .bitternessLessThan : .bitternessGreaterThan,
    .beerColorDarkerThan : .beerColorBrighterThan,
    .beerColorBrighterThan : .beerColorDarkerThan,
    .brewedBefore : .brewedAfter,
    .brewedAfter : .brewedBefore
]

enum FuzzyParameter: String {
    case beerName = "beer_name"
    case food
    case yeast
    case malt
    case hop
}
