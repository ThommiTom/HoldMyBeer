//
//  NetworkManager.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 12.05.23.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    
    func networkCall<T: Decodable>(with url: URL?, completionHandler completion: @escaping (Result<T, NetworkError>) -> Void) async {
        guard let url = url else {
            completion(.failure(.failedCreatingURL))
            return
        }
        
        let request = URLRequest(url: url)
        
        
        URLSession.shared.dataTask(with: request) { data, urlResponse, error in
            // handle eventual error
            guard error == nil else {
                completion(.failure(.unableToComplete))
                return
            }
            
            // check url response
            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            print("Status Code: \(httpResponse.statusCode) - \(request.url?.absoluteString ?? "URL n/a")")
            
            // check http status code
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidStatusCode))
                return
            }
            
            // check data availability
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            // parse data
            self.parse(data: data, completionHandler: completion)
        }
        .resume()
    }
    
    
    private func parse<T: Decodable>(data: Data, completionHandler completion: @escaping (Result<T, NetworkError>) -> Void) {
        do {
            let decoder = JSONDecoder()
            //decoder.dateDecodingStrategy = .iso8601
            
            let element: T = try decoder.decode(T.self, from: data)
            completion(.success(element))
        } catch let DecodingError.dataCorrupted(context) {
            print("Data corrupted: \(context)")
            completion(.failure(.invalidDecoding))
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            completion(.failure(.invalidDecoding))
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            completion(.failure(.invalidDecoding))
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
            completion(.failure(.invalidDecoding))
        } catch {
            print("Unknown error while decoding.")
            completion(.failure(.invalidDecoding))
        }
    }
}

