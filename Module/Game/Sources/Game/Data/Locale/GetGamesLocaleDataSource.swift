//
//  GetGamesLocaleDataSource.swift
//  Game
//
//  Created by Ikhwan Setyo on 26/12/25.
//


import Core
import Combine
import RealmSwift
import Foundation

public struct GetGamesLocaleDataSource: LocaleDataSource {

  public typealias Request = String

  public typealias Response = GameModuleEntity

  private let realm: Realm

  public init(realm: Realm) {
    self.realm = realm
  }

  public func list(request: String?) -> AnyPublisher<[GameModuleEntity], Error> {
    return Future<[GameModuleEntity], Error> { completion in
      let games: Results<GameModuleEntity> = {
        self.realm.objects(GameModuleEntity.self)
      }()
      completion(.success(games.toArray(ofType: GameModuleEntity.self)))

    }.eraseToAnyPublisher()
  }

  public func add(entities: [GameModuleEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      do {
        try self.realm.write {
          for game in entities {
            self.realm.add(game, update: .all)
          }
          completion(.success(true))
        }
      } catch {
        completion(.failure(DatabaseError.requestFailed))
      }

    }.eraseToAnyPublisher()
  }

  public func get(id: String) -> AnyPublisher<GameModuleEntity, Error> {
      let gameId = Int(id)!
      return Future<GameModuleEntity, Error> { completion in
          if let gameEntity = self.realm.object(ofType: GameModuleEntity.self, forPrimaryKey: gameId) {
              completion(.success(gameEntity))
          } else {
              completion(.failure(DatabaseError.invalidInstance))
          }
      }.eraseToAnyPublisher()
  }

  public func update(id: String, entity: GameModuleEntity) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
}
