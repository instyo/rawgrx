//
//  HomeRouter.swift
//  RAWGRX
//
//  Created by Ikhwan Setyo on 26/12/25.
//



import SwiftUI
import Core
import Game

class HomeRouter {

    func makeDetailView(for gameId: Int) -> some View {
        let useCase: Interactor<
              String,
              GameDomainModel,
              GetGameRepository<
                GetGamesLocaleDataSource,
                GetGameRemoteDataSource,
                GameTransformer>
        > = Injection.init().provideGame()
        
        let favoriteUseCase: Interactor<
              String,
              GameDomainModel,
              UpdateFavoriteGameRepository<
                GetFavoriteGamesLocaleDataSource,
                GameTransformer>
            > = Injection.init().provideUpdateFavorite()
        
        
        let presenter = GamePresenter(gameUseCase: useCase, favoriteUseCase: favoriteUseCase)
        
        return DetailView(presenter: presenter, gameId: gameId)
    }

}
