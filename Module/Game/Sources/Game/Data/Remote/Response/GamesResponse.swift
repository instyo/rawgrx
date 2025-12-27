//
//  GamesResponse.swift
//  Game
//
//  Created by Ikhwan Setyo on 26/12/25.
//


public struct GamesResponse: Decodable, Sendable {
    let results: [GameResponse]
}

public struct GameResponse: Decodable, Sendable {
    public let id: Int?
    public let name: String?
    public let image: String?
    public let rating: Double?
    public let released: String?
    public let rawDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, released, rating
        case image = "background_image"
        case rawDescription = "description_raw"
    }
}
