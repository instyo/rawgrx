//
//  GetGameRemoteDataSource.swift
//  Game
//
//  Created by Ikhwan Setyo on 26/12/25.
//


import Core
import Combine
import Alamofire
import Foundation

public struct GetGameRemoteDataSource : DataSource {

  public typealias Request = String

  public typealias Response = GameResponse

  private let endpoint: String

  public init(endpoint: String) {
    self.endpoint = endpoint
  }

  public func execute(request: Request?) -> AnyPublisher<Response, Error> {

    return Future<GameResponse, Error> { completion in

        guard let request = request else { return completion(.failure(URLError.invalidResponse) )}

      if let url = URL(string: self.endpoint + request) {
        AF.request(url)
          .validate()
          .responseDecodable(of: GameResponse.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
              completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }
}

