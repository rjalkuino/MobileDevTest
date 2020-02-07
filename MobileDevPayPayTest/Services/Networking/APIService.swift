//
//  APIService.swift
//  MobileDevPayPayTest
//
//  Created by QuantumCrowd on 2/7/20.
//  Copyright © 2020 Robert John Alkuino. All rights reserved.
//

import UIKit

public enum APIServiceError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case decodeError
}

class APIService<T:Decodable> {
    private init() {}
    private static var urlSession:URLSession {
        return URLSession.shared
    }
    private static var baseURL:URL {
        return URL(string: "http://api.currencylayer.com")!
    }
    private static var apiKey:String {
        return "9be0ed6e4173148ddae3110f19cc9263"
    }
    
    private static var jsonDecoder: JSONDecoder {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }
    
    enum Endpoint: String, CustomStringConvertible, CaseIterable {
        case currencies
        
        var description: String {
            switch self {
            case .currencies:
                return "live"
            }
        }
    }
    
    
    private static func fetch(url: URL,completion: @escaping(Result<T, APIServiceError>) -> Void) {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            completion(.failure(.invalidEndpoint))
            return 
        }
        
        let queryItems = [URLQueryItem(name: "access_key", value: apiKey)]
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        urlSession.dataTask(with: url) { (data,response,error) in
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                completion(.failure(.invalidEndpoint))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidEndpoint))
                return
            }

            do {
                let values = try jsonDecoder.decode(T.self, from: data)
                completion(.success(values))
                return
            } catch {
                print(error)
                completion(.failure(.decodeError))
                return
            }
        }.resume()
    }
    
    public static func get(from endpoint: Endpoint,completion: @escaping(Result<T, APIServiceError>) -> Void) {
        let movieURL = baseURL
            .appendingPathComponent(endpoint.description)
        
        return fetch(url: movieURL, completion: completion)
    }
}
