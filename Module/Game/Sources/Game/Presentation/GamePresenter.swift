// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import Combine
import Core

public class GamePresenter<
  GameUseCase: UseCase,
  FavoriteUseCase: UseCase
>: ObservableObject where
  GameUseCase.Request == String,
  GameUseCase.Response == GameDomainModel,
    FavoriteUseCase.Request == String,
    FavoriteUseCase.Response == GameDomainModel
{
  private var cancellables: Set<AnyCancellable> = []

  private let gameUseCase: GameUseCase
  private let favoriteUseCase: FavoriteUseCase

  @Published public var item: GameDomainModel?
  @Published public var errorMessage: String = ""
  @Published public var isLoading: Bool = false
  @Published public var isError: Bool = false

  public init(gameUseCase: GameUseCase, favoriteUseCase: FavoriteUseCase) {
      self.gameUseCase = gameUseCase
      self.favoriteUseCase = favoriteUseCase
  }

  public func getGame(request: GameUseCase.Request) {
    isLoading = true
    self.gameUseCase.execute(request: request)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure (let error):
          self.errorMessage = error.localizedDescription
          self.isError = true
          self.isLoading = false
        case .finished:
          self.isLoading = false
        }
      }, receiveValue: { item in
        self.item = item
      })
      .store(in: &cancellables)
  }
    
    public func updateFavoriteGame(request: FavoriteUseCase.Request) {
        self.favoriteUseCase.execute(request: request)
          .receive(on: RunLoop.main)
          .sink(receiveCompletion: { completion in
            switch completion {
            case .failure:
              self.errorMessage = String(describing: completion)
            case .finished:
              self.isLoading = false
            }
          }, receiveValue: { result in
              let game = GameDomainModel(
                id: self.item?.id ?? 0,
                name: self.item?.name ?? "",
                released: self.item?.released ?? "",
                image: self.item?.image ?? "",
                rating: self.item?.rating ?? 0.0,
                rawDescription: self.item?.rawDescription ?? "",
                favorite: result.favorite
              )
            self.item = game
          })
          .store(in: &cancellables)
      }


}
