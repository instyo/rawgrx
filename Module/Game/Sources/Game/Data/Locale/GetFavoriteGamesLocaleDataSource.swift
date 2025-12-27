//
//  GetFavoriteGamesLocaleDataSource.swift
//  Game
//
//  Created by Ikhwan Setyo on 26/12/25.
//


import Core
import Combine
import RealmSwift
import Foundation

public struct GetFavoriteGamesLocaleDataSource : LocaleDataSource {

  public typealias Request = String
  public typealias Response = GameModuleEntity
  private let realm: Realm

  public init(realm: Realm) {
    self.realm = realm
  }

  public func list(request: String?) -> AnyPublisher<[GameModuleEntity], Error> {
    return Future<[GameModuleEntity], Error> { completion in

      let gameEntities = {
        self.realm.objects(GameModuleEntity.self)
          .filter("favorite = \(true)")
      }()
      completion(.success(gameEntities.toArray(ofType: GameModuleEntity.self)))

    }.eraseToAnyPublisher()
  }

  public func add(entities: [GameModuleEntity]) -> AnyPublisher<Bool, Error> {
    fatalError()
  }

  public func get(id: String) -> AnyPublisher<GameModuleEntity, Error> {
      let gameId = Int(id)!
      
    return Future<GameModuleEntity, Error> { completion in
      if let gameEntity = {
        self.realm.objects(GameModuleEntity.self).filter("id = \(gameId)")
      }().first {
        do {
          try self.realm.write {
              gameEntity.setValue(!gameEntity.favorite, forKey: "favorite")
          }
          completion(.success(gameEntity))
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }

  public func update(id: String, entity: GameModuleEntity) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
}
