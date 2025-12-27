//
//  DetailView.swift
//  RAWGRX
//
//  Created by Ikhwan Setyo on 26/12/25.
//

import SwiftUI
import Core
import Game
import Kingfisher

struct DetailView: View {
    @StateObject var presenter: GamePresenter<
      Interactor<String, GameDomainModel, GetGameRepository<GetGamesLocaleDataSource, GetGameRemoteDataSource, GameTransformer>>,
      Interactor<String, GameDomainModel, UpdateFavoriteGameRepository<GetFavoriteGamesLocaleDataSource, GameTransformer>>
    >

    let gameId: Int
    
    var body: some View {
        ZStack {
            if !presenter.errorMessage.isEmpty {
                errorMessage
            } else {
                if presenter.isLoading {
                    loadingIndicator
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 0) {
                            imageGame
                            content
                                .padding(.horizontal, 20)
                        }
                    }
                }
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing, content: {
                if presenter.item != nil {
                    Button(action : {
                        presenter.updateFavoriteGame(request: "\(String(describing: presenter.item!.id))")
                    }) {
                        if presenter.item?.favorite == true {
                            Image(systemName: "heart.fill")
                        } else {
                            Image(systemName: "heart")
                        }
                    }
                }
            })
        }
        .onAppear {
            // Reset the presenter state when view appears
            presenter.item = nil
            presenter.isLoading = true
            presenter.isError = false
            presenter.errorMessage = ""
            
            presenter.getGame(request: "/\(gameId)?key=\(API.apiKey)")
        }
        
        .navigationBarTitle(Text(self.presenter.item?.name ?? ""), displayMode: .inline)
    }
}

extension DetailView {
    var spacer: some View {
        Spacer()
    }
    
    var errorMessage: some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 50))
                .foregroundColor(.red.opacity(0.7))
            Text("Failed to load")
                .font(.headline)
                .foregroundColor(.secondary)
        }
    }
    
    var loadingIndicator: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.2)
            Text("Loading...")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    var imageGame: some View {
        KFImage(URL(string: self.presenter.item?.image ?? ""))
            .placeholder {
                Rectangle()
                    .fill(Color.gray.opacity(0.15))
                    .overlay(
                        ProgressView()
                            .tint(.white)
                    )
            }
            .resizable()
            .scaledToFit()
            .frame(height: 280)
            .frame(maxWidth: .infinity)
            .clipped()
            .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
    }
    
    var description: some View {
        Text(self.presenter.item?.rawDescription ?? "")
            .font(.body)
            .foregroundColor(.primary.opacity(0.85))
            .lineSpacing(4)
    }
    
    func headerTitle(_ title: String) -> some View {
        return Text(title)
            .font(.title2)
            .fontWeight(.bold)
    }
    
    func itemRow(title: String, description: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
                .tracking(0.5)
            
            Text(description)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            headerTitle("Game Info")
                .padding(.top, 24)
                .padding(.bottom, 16)
            
            HStack {
                Text("Released : \(self.presenter.item?.released ?? "")")
                    .font(.system(size: 14))
                Spacer()
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
                    .font(.system(size: 14))
                Text(String(format: "%.1f", self.presenter.item?.rating ?? 0.0))
                    .font(.system(size: 14))
            }
            
            headerTitle("Description")
                .padding(.top, 24)
                .padding(.bottom, 16)
            
            description
                .padding(.bottom, 32)
        }
    }
}
