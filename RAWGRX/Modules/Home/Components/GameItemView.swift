//
//  GameItemView.swift
//  RAWGRX
//
//  Created by Ikhwan Setyo on 26/12/25.
//



import SwiftUI
import Kingfisher
import Game

struct GameItemView: View {
    let game: GameDomainModel

    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading, spacing: 0) {

                KFImage(URL(string: game.image))
                    .placeholder {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .overlay(ProgressView())
                    }
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.width * 0.56)
                    .clipped()

                VStack(alignment: .leading, spacing: 8) {
                    Text(game.name)
                        .font(.system(size: 15, weight: .semibold))
                        .lineLimit(2)

                    HStack {
                        Text(game.released)
                            .font(.system(size: 13))
                            .foregroundColor(.secondary)

                        Spacer(minLength: 4)

                        HStack(spacing: 3) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 11))
                                .foregroundColor(.yellow)

                            Text(String(format: "%.1f", game.rating))
                                .font(.system(size: 13, weight: .medium))
                        }
                    }
                }
                .padding(12)
            }
            .background(Color(.secondarySystemGroupedBackground))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
        .frame(height: 160)
    }
}

