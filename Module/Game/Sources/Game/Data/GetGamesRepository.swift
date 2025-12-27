//
//  GetGamesRepository.swift
//  Game
//
//  Created by Ikhwan Setyo on 26/12/25.
//


import Core
import Combine

// 1
public struct GetGamesRepository<
  GameLocaleDataSource: LocaleDataSource,
  RemoteDataSource: DataSource,
  Transformer: Mapper
>: Repository where
// 2
  GameLocaleDataSource.Response == GameModuleEntity,
  RemoteDataSource.Response == [GameResponse],
  Transformer.Response == [GameResponse],
  Transformer.Entity == [GameModuleEntity],
  Transformer.Domain == [GameDomainModel]
{

  // 3
  public typealias Request = Any
  public typealias Response = [GameDomainModel]

  private let localeDataSource: GameLocaleDataSource
  private let remoteDataSource: RemoteDataSource
  private let mapper: Transformer

  public init(
    localeDataSource: GameLocaleDataSource,
    remoteDataSource: RemoteDataSource,
    mapper: Transformer) {

      self.localeDataSource = localeDataSource
      self.remoteDataSource = remoteDataSource
      self.mapper = mapper
    }

  // 4
  public func execute(request: Any?) -> AnyPublisher<[GameDomainModel], Error> {
    return self.localeDataSource.list(request: nil)
      .flatMap { result -> AnyPublisher<[GameDomainModel], Error> in
        if result.isEmpty {
          return self.remoteDataSource.execute(request: nil)
            .map { self.mapper.transformResponseToEntity(request: nil, response: $0) }
            .catch { _ in self.localeDataSource.list(request: nil) }
            .flatMap { self.localeDataSource.add(entities: $0) }
            .filter { $0 }
            .flatMap { _ in self.localeDataSource.list(request: nil)
                .map { self.mapper.transformEntityToDomain(entity: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return self.localeDataSource.list(request: nil)
            .map { self.mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }
}
