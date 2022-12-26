//
//  LanguageViewModelUnitTest.swift
//  GamioTests
//
//  Created by Gokberk Ozcan on 17.12.2022.
//

import XCTest

final class LanguageViewModelUnitTest: XCTestCase {

    var viewModel: LanguageViewModel!
    override func setUpWithError() throws {
        viewModel = LanguageViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetLanguageCount() throws {
        //Given
        XCTAssertEqual(viewModel.getLanguageCount(), 2)

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

