//
//  FavoriteView.swift
//  RAWGRX
//
//  Created by Ikhwan Setyo on 26/12/25.
//

import SwiftUI
import Core
import Game

struct FavoriteView: View {
    
    @ObservedObject var presenter: GetListPresenter<String, GameDomainModel, Interactor<String, [GameDomainModel], GetFavoriteGamesRepository<GetFavoriteGamesLocaleDataSource, GamesTransformer>>>
    
    @State private var hasLoaded = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            if presenter.isLoading {
                VStack(spacing: 16) {
                    ProgressView()
                        .scaleEffect(1.2)
                    Text("Loading...")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            } else if presenter.isError {
                VStack(spacing: 12) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.red.opacity(0.7))
                    Text("Error loading favorites")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
            } else if presenter.list.count == 0 {
                VStack(spacing: 12) {
                    Image(systemName: "heart.slash")
                        .font(.system(size: 50))
                        .foregroundColor(.secondary)
                    Text("No favorite games yet")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(presenter.list, id: \.id) { item in
                            self.linkBuilder(for: item, content: {
                                GameItemView(game: item)
                            })
                            .buttonStyle(.plain)
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            presenter.getList(request: nil)
        }
        .navigationBarTitle(
            Text("Favorite Games"),
            displayMode: .automatic
        )
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
