//
//  GameListViewModelUnitTest.swift
//  GamioTests
//
//  Created by Gokberk Ozcan on 17.12.2022.
//

import XCTest
final class GameListViewModelUnitTest: XCTestCase {
    
    var viewModel: GameListViewModel!
    var fetchExpectation: XCTestExpectation!
    
    override func setUpWithError() throws {
        viewModel = GameListViewModel()
        viewModel.delegate = self
        fetchExpectation = expectation(description: "fetchGames")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
       
    func testGetGameCount() throws {
        //Given
        XCTAssertEqual(viewModel.getGameCount(), 0)
        
        //When
        viewModel.fetchGames()
        waitForExpectations(timeout: 10)
        
        //Then
        XCTAssertEqual(viewModel.getGameCount(), 40)
    }

}
extension GameListViewModelUnitTest: GameListViewModelDelegate {
    func gamesLoaded(gamesArray: [GameListModel]?) {
        fetchExpectation.fulfill()
    }
    
    func latesGamesLoaded(latestGames: [GameListModel]?) {
        fetchExpectation.fulfill()
    }
    
    func topRatedGamesLoaded(topRatedGames: [GameListModel]?) {
        fetchExpectation.fulfill()
    }
}
