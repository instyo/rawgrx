//
//  API.swift
//  RAWGRX
//
//  Created by Ikhwan Setyo on 27/12/25.
//


import Foundation

struct API {
    
    static let baseUrl = "https://api.rawg.io/api/games"
    
    static var apiKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            return ""
        }
        
        return key
    }
}