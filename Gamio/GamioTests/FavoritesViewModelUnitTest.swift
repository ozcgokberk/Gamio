//
//  FavoritesViewModelUnitTest.swift
//  GamioTests
//
//  Created by Gokberk Ozcan on 17.12.2022.
//

import XCTest

final class FavoritesViewModelUnitTest: XCTestCase {

    var viewModel: FavoritesViewModel!
    var fetchExpectation: XCTestExpectation!
    
    override func setUpWithError() throws {
        viewModel = FavoritesViewModel()
        viewModel.delegate = self
        fetchExpectation = expectation(description: "fetchFavorites")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func testGetFavoritesCount() throws {
//        //Given
//        XCTAssertEqual(viewModel.getFavoritesCount(), 0)
//        
//        //When
//        viewModel.fetchFavorites()
//
//        waitForExpectations(timeout: 10)
//        
//        //Then
//        XCTAssertEqual(viewModel.getFavoritesCount(), 40)
//
//    }
}

extension FavoritesViewModelUnitTest: FavoritesViewModelDelegate {
    func favoritesLoaded(favorites: [Favorites]) {
        fetchExpectation.fulfill()
    }
}
