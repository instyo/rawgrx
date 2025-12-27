//
//  GetFavoriteGamesRepository.swift
//  Game
//
//  Created by Ikhwan Setyo on 26/12/25.
//

import Core
import Combine

public struct GetFavoriteGamesRepository<
  GameLocaleDataSource: LocaleDataSource,
  Transformer: Mapper
>: Repository
where
GameLocaleDataSource.Request == String,
GameLocaleDataSource.Response == GameModuleEntity,
  Transformer.Request == String,
  Transformer.Response == [GameResponse],
  Transformer.Entity == [GameModuleEntity],
  Transformer.Domain == [GameDomainModel]
{

  public typealias Request = String
  public typealias Response = [GameDomainModel]

  private let localeDataSource: GameLocaleDataSource
  private let mapper: Transformer

  public init(
    localeDataSource: GameLocaleDataSource,
    mapper: Transformer
  ) {

    self.localeDataSource = localeDataSource
    self.mapper = mapper
  }

  public func execute(request: String?) -> AnyPublisher<[GameDomainModel], Error> {
    return self.localeDataSource.list(request: request)
      .map { self.mapper.transformEntityToDomain(entity: $0) }
      .eraseToAnyPublisher()
  }
}
