//
//  RAWGRXApp.swift
//  RAWGRX
//
//  Created by Ikhwan Setyo on 26/12/25.
//

import SwiftUI
import Core
import Game

let gameUseCase: Interactor<
    Any,
    [GameDomainModel],
    GetGamesRepository<
        GetGamesLocaleDataSource,
        GetGamesRemoteDataSource,
        GamesTransformer>
> = Injection.init().provideGames()

let favoriteUseCase: Interactor<
    String,
    [GameDomainModel],
    GetFavoriteGamesRepository<
        GetFavoriteGamesLocaleDataSource,
        GamesTransformer>
> = Injection.init().provideFavorite()


@main
struct RAWGRXApp: App {
    let gamesPresenter = GetListPresenter(useCase: gameUseCase)
    let favoritePresenter = GetListPresenter(useCase: favoriteUseCase)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gamesPresenter)
                .environmentObject(favoritePresenter)
        }
    }
}
