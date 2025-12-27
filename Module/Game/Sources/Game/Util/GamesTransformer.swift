//
//  GamesTransformer.swift
//  Game
//
//  Created by Ikhwan Setyo on 26/12/25.
//


import Core

public struct GamesTransformer: Mapper {
    public typealias Request = String
    public typealias Response = [GameResponse]
    public typealias Entity = [GameModuleEntity]
    public typealias Domain = [GameDomainModel]
    
    public init() { }
    
    public func transformResponseToEntity(request: String?, response: [GameResponse]) -> [GameModuleEntity] {
        return response.map { result in
            let newGame = GameModuleEntity()
            newGame.id = result.id ?? 0
            newGame.name = result.name ?? ""
            newGame.released = result.released ?? ""
            newGame.image = result.image ?? ""
            newGame.rating = result.rating ?? 0.0
            newGame.rawDescription = result.rawDescription ?? ""
            newGame.favorite = false
            return newGame
        }
    }
    
    public func transformEntityToDomain(entity: [GameModuleEntity]) -> [GameDomainModel] {
        return entity.map { result in
            return GameDomainModel(
                id: result.id,
                name: result.name,
                released: result.released,
                image: result.image,
                rating: result.rating,
                rawDescription: result.rawDescription,
                favorite: result.favorite
            )
        }
    }
}
