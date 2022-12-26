//
//  GenreViewModelUnitTest.swift
//  GamioTests
//
//  Created by Gokberk Ozcan on 17.12.2022.
//

import XCTest

final class GenreViewModelUnitTest: XCTestCase {
    
    var viewModel: GenreViewModel!
    var detailExpectation: XCTestExpectation!
    
    override func setUpWithError() throws {
        viewModel = GenreViewModel()
        detailExpectation = expectation(description: "getGamesByCategorie")
        viewModel.delegate = self
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetGameCount() throws {
        //Given
        XCTAssertEqual(viewModel.getCountOfGames(), nil)
        
        //When
        viewModel.getGamesByCategorie(genre: "action")
        waitForExpectations(timeout: 10)
        
        //Then
        XCTAssertEqual(viewModel.getCountOfGames(), 40)
    }
}

extension GenreViewModelUnitTest: GenreListViewModelDelegate {
    func gamesLoaded(filteredGenre: [GenreModel]?) {
        detailExpectation.fulfill()
    }
}

