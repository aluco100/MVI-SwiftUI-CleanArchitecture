//
//  APIClient.swift
//  Networking
//
//  Created by Alfredo Luco on 25-06-21.
//

import Foundation

public enum APIClient {
    
    // MARK: - Endpoints
    
    case fetchCategories(params: [String: Any]?)
    
    // MARK: - Base URL
    
    var baseURL: String {
        APIConstants.baseURL
    }
    
    // MARK: - Path
    
    var path: String {
        switch self {
        case .fetchCategories(_):
            return "api/json/v1/1/categories.php"
        }
    }
    
    // MARK: - As URL Request
    
    public func asURLRequest() throws -> URLRequest {
        
        guard var urlComponents = URLComponents(string: self.baseURL + self.path) else {
            throw NSError(domain: "TheMealDB", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }
        
        // change api key if there's
        
        var queryItems: [URLQueryItem] = [URLQueryItem(name: "api-key", value: "blablabla")]
        
        // MARK: - Set Params
        
        func setParams(_ params: [String: Any], _ queryItems: inout [URLQueryItem]) {
            params.keys.forEach({
                queryItems.append(URLQueryItem(name: $0, value: params[$0] as? String))
            })
        }
        
        // Set Params
        
        switch self {
        case .fetchCategories(params: let params):
            if params != nil {
                setParams(params!, &queryItems)
            }
            break
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            throw NSError(domain: "TheMealDB", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }
        
        var request = URLRequest(url: url)

        request.setValue("themealdb.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        request.setValue("true", forHTTPHeaderField: "useQueryString")
        
        return URLRequest(url: url)
    }
    
}
