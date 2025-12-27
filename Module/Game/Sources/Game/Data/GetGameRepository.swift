//
//  GetGameRepository.swift
//  Game
//
//  Created by Ikhwan Setyo on 26/12/25.
//

import Core
import Combine

public struct GetGameRepository<
  LocalDataSource: LocaleDataSource,
  RemoteDataSource: DataSource,
  Transformer: Mapper
>: Repository
where
  LocalDataSource.Response == GameModuleEntity,
  RemoteDataSource.Request == String,
  RemoteDataSource.Response == GameResponse,
  Transformer.Request == String,
  Transformer.Response == GameResponse,
  Transformer.Entity == GameModuleEntity,
  Transformer.Domain == GameDomainModel
{
    
  public typealias Request = String
  public typealias Response = GameDomainModel
    
  private let localeDataSource: LocalDataSource
  private let remoteDataSource: RemoteDataSource
  private let mapper: Transformer
    
  public init(
    localeDataSource: LocalDataSource,
    remoteDataSource: RemoteDataSource,
    mapper: Transformer
  ) {
    self.localeDataSource = localeDataSource
    self.remoteDataSource = remoteDataSource
    self.mapper = mapper
  }
    
  public func execute(request: String?) -> AnyPublisher<GameDomainModel, Error> {
   return remoteDataSource.execute(request: request)
      .map { mapper.transformResponseToEntity(request: request, response: $0) }
      .flatMap { entity -> AnyPublisher<GameDomainModel, Error> in
          return self.localeDataSource.get(id: String(entity.id))
              .map { localeEntity -> GameModuleEntity in
                  entity.favorite = localeEntity.favorite
                  return entity
              }
              .catch { _ in
                  return Just(entity).setFailureType(to: Error.self)
              }
              .flatMap { entityToSave -> AnyPublisher<GameDomainModel, Error> in
                  return self.localeDataSource.add(entities: [entityToSave])
                      .map { _ in
                          return self.mapper.transformEntityToDomain(entity: entityToSave)
                      }
                      .eraseToAnyPublisher()
              }
              .eraseToAnyPublisher()
      }
      .eraseToAnyPublisher()
  }
}
