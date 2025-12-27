//
//  GameTransformer.swift
//  Game
//
//  Created by Ikhwan Setyo on 26/12/25.
//

import Core

public struct GameTransformer: Mapper {
    public typealias Request = String
    public typealias Response = GameResponse
    public typealias Entity = GameModuleEntity
    public typealias Domain = GameDomainModel
    
    public init() { }
    
    public func transformResponseToEntity(request: String?, response: GameResponse) -> GameModuleEntity {
        let newGame = GameModuleEntity()
        newGame.id = response.id ?? 0
        newGame.name = response.name ?? ""
        newGame.released = response.released ?? ""
        newGame.image = response.image ?? ""
        newGame.rating = response.rating ?? 0.0
        newGame.rawDescription = response.rawDescription ?? ""
        newGame.favorite = false
        return newGame
    }
    
    public func transformEntityToDomain(entity: GameModuleEntity) -> GameDomainModel {
        return GameDomainModel(
            id: entity.id,
            name: entity.name,
            released: entity.released,
            image: entity.image,
            rating: entity.rating,
            rawDescription: entity.rawDescription,
            favorite: entity.favorite
        )
    }
}
