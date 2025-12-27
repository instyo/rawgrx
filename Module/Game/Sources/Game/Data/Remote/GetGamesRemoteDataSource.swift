//
//  GetGamesRemoteDataSource.swift
//  Game
//
//  Created by Ikhwan Setyo on 26/12/25.
//


import Core
import Combine
import Alamofire
import Foundation

public struct GetGamesRemoteDataSource: DataSource {
    public typealias Request = Any
    
    public typealias Response = [GameResponse]
    
    private let _endpoint: String
    
    public init(endpoint: String) {
        _endpoint = endpoint
    }
    
    public func execute(request: Any?) -> AnyPublisher<[GameResponse], Error> {
        return Future<[GameResponse], Error> { completion in
            if let url = URL(string: _endpoint) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: GamesResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.results))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}
