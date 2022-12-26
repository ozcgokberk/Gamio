//
//  GameDetailViewModelUnitTest.swift
//  GamioTests
//
//  Created by Gokberk Ozcan on 17.12.2022.
//

import XCTest

final class GameDetailViewModelUnitTest: XCTestCase {
    
    var viewModel: GameDetailViewModel!
    var detailExpectation: XCTestExpectation!
    
    override func setUpWithError() throws {
        viewModel = GameDetailViewModel()
        detailExpectation = expectation(description: "fetchGameDetail(id: Int)")
        viewModel.delegate = self
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetGameImageUrl() throws {
        XCTAssertEqual(viewModel.getGameImageUrl(), nil)

        viewModel.fetchGameDetail(id: 3498)
        waitForExpectations(timeout: 10)
        
        XCTAssertEqual(viewModel.getGameImageUrl(), "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg")
    }
    
    func testGetGameAdditionalImageUrl() {
        XCTAssertEqual(viewModel.getAdditionalImageUrl(), nil)

        viewModel.fetchGameDetail(id: 3498)
        waitForExpectations(timeout: 10)
        
        XCTAssertEqual(viewModel.getAdditionalImageUrl()?.absoluteString, "https://media.rawg.io/media/screenshots/5f5/5f5a38a222252d996b18962806eed707.jpg")

    }
    
    func testGetGameName() {
        XCTAssertEqual(viewModel.getGameName(), "")

        viewModel.fetchGameDetail(id: 3498)
        waitForExpectations(timeout: 10)
        
        XCTAssertEqual(viewModel.getGameName(), "Grand Theft Auto V")
    }

    func testGetGameDescription() {
        XCTAssertEqual(viewModel.getDescription(), "Not Found")

        viewModel.fetchGameDetail(id: 3498)
        waitForExpectations(timeout: 10)
        
        XCTAssertEqual(viewModel.getDescription(), "<p>Rockstar Games went bigger, since their previous installment of the series. You get the complicated and realistic world-building from Liberty City of GTA4 in the setting of lively and diverse Los Santos, from an old fan favorite GTA San Andreas. 561 different vehicles (including every transport you can operate) and the amount is rising with every update. <br />\nSimultaneous storytelling from three unique perspectives: <br />\nFollow Michael, ex-criminal living his life of leisure away from the past, Franklin, a kid that seeks the better future, and Trevor, the exact past Michael is trying to run away from. <br />\nGTA Online will provide a lot of additional challenge even for the experienced players, coming fresh from the story mode. Now you will have other players around that can help you just as likely as ruin your mission. Every GTA mechanic up to date can be experienced by players through the unique customizable character, and community content paired with the leveling system tends to keep everyone busy and engaged.</p>")
    }
    
    func testGetGameMetacritic() {
        XCTAssertEqual(viewModel.getMetacritic(), 0)
        
        viewModel.fetchGameDetail(id: 3498)
        waitForExpectations(timeout: 10)
        
        XCTAssertEqual(viewModel.getMetacritic(), 91)
    }
    
    func testGetReleasedDate() {
        XCTAssertEqual(viewModel.getReleasedDate(), "Not Found")
        
        viewModel.fetchGameDetail(id: 3498)
        waitForExpectations(timeout: 10)
        
        XCTAssertEqual(viewModel.getReleasedDate(), "2013-09-17")

    }
    
    func testGetRating() {
        XCTAssertEqual(viewModel.getRating(), 0)
        
        viewModel.fetchGameDetail(id: 3498)
        waitForExpectations(timeout: 10)
        
        XCTAssertEqual(viewModel.getRating(), 4.47)
    }
    
    func  testGetGenres() {
        XCTAssertEqual(viewModel.getGenres(), [])
        
        viewModel.fetchGameDetail(id: 3498)
        waitForExpectations(timeout: 10)
        
        XCTAssertEqual(viewModel.getGenres(), [GameDetailModel.Genre(name: "Action"), GameDetailModel.Genre(name: "Adventure")])
    }
    
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}

extension GameDetailViewModelUnitTest: GameDetailViewModelDelegate {
    func gameDetailLoaded() {
        detailExpectation.fulfill()
    }
}
