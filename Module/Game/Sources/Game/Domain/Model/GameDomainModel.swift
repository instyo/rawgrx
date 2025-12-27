//
//  GameDomainModel.swift
//  Game
//
//  Created by Ikhwan Setyo on 26/12/25.
//


public struct GameDomainModel: Equatable, Identifiable {
    
    public let id: Int
    public let name: String
    public let released: String
    public let image: String
    public let rating: Double
    public let rawDescription: String
    public let favorite: Bool
    
    public init(id: Int, name: String, released: String, image: String, rating: Double, rawDescription: String, favorite: Bool = false) {
        self.id = id
        self.name = name
        self.released = released
        self.image = image
        self.rating = rating
        self.rawDescription = rawDescription
        self.favorite = favorite
    }
}
