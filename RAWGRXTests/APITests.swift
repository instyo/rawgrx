//
//  APITests.swift
//  RAWGRX
//
//  Created by Ikhwan Setyo on 27/12/25.
//


import XCTest
@testable import RAWGRX

final class APITests: XCTestCase {
    
    func testBaseURL_ShouldBeCorrect() {
        // Given
        let expectedURL = "https://api.rawg.io/api/games"
        
        // When
        let actualURL = API.baseUrl
        
        // Then
        XCTAssertEqual(actualURL, expectedURL)
    }
    
    func testAPIKey_ShouldNotBeEmpty() {
        // When
        let apiKey = API.apiKey
        
        // Then
        XCTAssertFalse(apiKey.isEmpty, "API key should not be empty")
    }
    
    func testAPIKey_ShouldMatchInfoPlist() {
        // Given
        let expectedKey = "dbd73305786541f7b40b4926c1d5894d"
        
        // When
        let actualKey = API.apiKey
        
        // Then
        XCTAssertEqual(actualKey, expectedKey)
    }
}