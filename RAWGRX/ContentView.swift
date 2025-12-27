//
//  ContentView.swift
//  RAWGRX
//
//  Created by Ikhwan Setyo on 26/12/25.
//

import SwiftUI
import Game
import Core

struct ContentView: View {
    @EnvironmentObject var homePresenter: GetListPresenter<Any, GameDomainModel, Interactor<Any, [GameDomainModel], GetGamesRepository<GetGamesLocaleDataSource, GetGamesRemoteDataSource, GamesTransformer>>>
    @EnvironmentObject var favoritePresenter: GetListPresenter<String, GameDomainModel, Interactor<String, [GameDomainModel], GetFavoriteGamesRepository<GetFavoriteGamesLocaleDataSource, GamesTransformer>>>
    
    var body: some View {
        TabView {
            NavigationStack {
                HomeView(presenter: homePresenter)
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            
            NavigationStack {
                FavoriteView(presenter: favoritePresenter)
            }
            .tabItem {
                Label("Favorite", systemImage: "heart")
            }
            
            NavigationStack {
                AboutView()
            }
            .tabItem {
                Label("About", systemImage: "person.crop.circle")
            }
        }
    }
}
