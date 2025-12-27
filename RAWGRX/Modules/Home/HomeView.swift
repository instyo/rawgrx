//
//  HomeView.swift
//  RAWGRX
//
//  Created by Ikhwan Setyo on 26/12/25.
//

import SwiftUI
import Core
import Game

struct HomeView: View {
    
    @ObservedObject var presenter: GetListPresenter<Any, GameDomainModel, Interactor<Any, [GameDomainModel], GetGamesRepository<GetGamesLocaleDataSource, GetGamesRemoteDataSource, GamesTransformer>>>

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                if presenter.isLoading {
                    Text("Loading")
                } else if presenter.isError {
                    Text("Error")
                } else if presenter.list.isEmpty {
                    Text("Empty")
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(presenter.list, id: \.id) { item in
                                self.linkBuilder(for: item, content: {
                                    GameItemView(game: item)
                                }).buttonStyle(.plain)
                            }
                        }
                        .padding()
                    }
                }
            }.onAppear {
                self.presenter.getList(request: nil)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("RAWG")
        }
    }
    
    func linkBuilder<Content: View>(
      for game: GameDomainModel,
      @ViewBuilder content: () -> Content
    ) -> some View {
      NavigationLink(
        destination: HomeRouter().makeDetailView(for: game.id)
      ) { content() }
    }
}
