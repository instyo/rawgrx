//
//  Injection.swift
//  RAWGRX
//
//  Created by Ikhwan Setyo on 26/12/25.
//


import UIKit
import Game
import Core
import RealmSwift

final class Injection: NSObject {
    
    private let realm = try? Realm()
    
    func provideGame<U: UseCase>() -> U where U.Request == String, U.Response == GameDomainModel {
        
        let remote = GetGameRemoteDataSource(endpoint: API.baseUrl)
        let locale = GetGamesLocaleDataSource(realm: realm!)
        
        let mapper = GameTransformer()
        
        let repository = GetGameRepository(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper
        )
        
        return Interactor(repository: repository) as! U
    }
    
    
    func provideGames<U: UseCase>() -> U where U.Request == Any, U.Response == [GameDomainModel] {
        // 3
        let locale = GetGamesLocaleDataSource(realm: realm!)
        
        // 4
        let remote = GetGamesRemoteDataSource(endpoint: "\(API.baseUrl)?key=\(API.apiKey)")
        
        // 5
        let mapper = GamesTransformer()
        
        // 6
        let repository = GetGamesRepository(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper
        )
        
        // 7
        return Interactor(repository: repository) as! U
    }
    
    func provideUpdateFavorite<U: UseCase>() -> U where U.Request == String, U.Response == GameDomainModel {
        let locale = GetFavoriteGamesLocaleDataSource(realm: realm!)
        let mapper = GameTransformer()
        
        let repository = UpdateFavoriteGameRepository(localeDataSource: locale, mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
    
    func provideFavorite<U: UseCase>() -> U where U.Request == String, U.Response == [GameDomainModel] {
        let locale = GetFavoriteGamesLocaleDataSource(realm: realm!)
        let mapper = GamesTransformer()
        
        let repository = GetFavoriteGamesRepository(localeDataSource: locale, mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
}
