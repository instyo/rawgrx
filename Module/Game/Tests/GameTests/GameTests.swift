//
//  GameTests.swift
//  Game
//
//  Created by Ikhwan Setyo on 27/12/25.
//

import XCTest
import Combine
@testable import Game

final class GameDomainModelTests: XCTestCase {
    
    func testGameDomainModelInitialization() {
        // Given & When
        let game = GameDomainModel(
            id: 1,
            name: "Test Game",
            released: "2024-01-01",
            image: "https://example.com/image.jpg",
            rating: 4.5,
            rawDescription: "A test description",
            favorite: true
        )
        
        // Then
        XCTAssertEqual(game.id, 1)
        XCTAssertEqual(game.name, "Test Game")
        XCTAssertEqual(game.released, "2024-01-01")
        XCTAssertEqual(game.image, "https://example.com/image.jpg")
        XCTAssertEqual(game.rating, 4.5)
        XCTAssertEqual(game.rawDescription, "A test description")
        XCTAssertTrue(game.favorite)
    }
    
    func testGameDomainModelDefaultFavorite() {
        // Given & When
        let game = GameDomainModel(
            id: 1,
            name: "Test Game",
            released: "2024-01-01",
            image: "https://example.com/image.jpg",
            rating: 4.5,
            rawDescription: "A test description"
        )
        
        // Then
        XCTAssertFalse(game.favorite)
    }
    
    func testGameDomainModelEquality() {
        // Given
        let game1 = GameDomainModel(id: 1, name: "Game", released: "2024", image: "img.jpg", rating: 4.0, rawDescription: "Desc", favorite: false)
        let game2 = GameDomainModel(id: 1, name: "Game", released: "2024", image: "img.jpg", rating: 4.0, rawDescription: "Desc", favorite: false)
        let game3 = GameDomainModel(id: 2, name: "Game", released: "2024", image: "img.jpg", rating: 4.0, rawDescription: "Desc", favorite: false)
        
        // Then
        XCTAssertEqual(game1, game2)
        XCTAssertNotEqual(game1, game3)
    }
}

final class GameResponseTests: XCTestCase {
    
    func testGameResponseDecoding() throws {
        // Given
        let json = """
        {
            "id": 123,
            "name": "Test Game",
            "background_image": "https://example.com/image.jpg",
            "rating": 4.75,
            "released": "2024-12-27",
            "description_raw": "This is a test game"
        }
        """
        
        let data = json.data(using: .utf8)!
        
        // When
        let decoder = JSONDecoder()
        let response = try decoder.decode(GameResponse.self, from: data)
        
        // Then
        XCTAssertEqual(response.id, 123)
        XCTAssertEqual(response.name, "Test Game")
        XCTAssertEqual(response.image, "https://example.com/image.jpg")
        XCTAssertEqual(response.rating, 4.75)
        XCTAssertEqual(response.released, "2024-12-27")
        XCTAssertEqual(response.rawDescription, "This is a test game")
    }
    
    func testGameResponseDecodingWithMissingFields() throws {
        // Given
        let json = """
        {
            "id": 123
        }
        """
        
        let data = json.data(using: .utf8)!
        
        // When
        let decoder = JSONDecoder()
        let response = try decoder.decode(GameResponse.self, from: data)
        
        // Then
        XCTAssertEqual(response.id, 123)
        XCTAssertNil(response.name)
        XCTAssertNil(response.image)
        XCTAssertNil(response.rating)
        XCTAssertNil(response.released)
        XCTAssertNil(response.rawDescription)
    }
}

final class GamesResponseTests: XCTestCase {
    
    func testGamesResponseDecoding() throws {
        // Given
        let json = """
        {
            "results": [
                {
                    "id": 1,
                    "name": "Game 1",
                    "background_image": "img1.jpg",
                    "rating": 4.0,
                    "released": "2024-01-01",
                    "description_raw": "First game"
                },
                {
                    "id": 2,
                    "name": "Game 2",
                    "background_image": "img2.jpg",
                    "rating": 4.5,
                    "released": "2024-02-01",
                    "description_raw": "Second game"
                }
            ]
        }
        """
        
        let data = json.data(using: .utf8)!
        
        // When
        let decoder = JSONDecoder()
        let response = try decoder.decode(GamesResponse.self, from: data)
        
        // Then
        XCTAssertEqual(response.results.count, 2)
        XCTAssertEqual(response.results[0].id, 1)
        XCTAssertEqual(response.results[0].name, "Game 1")
        XCTAssertEqual(response.results[1].id, 2)
        XCTAssertEqual(response.results[1].name, "Game 2")
    }
}
