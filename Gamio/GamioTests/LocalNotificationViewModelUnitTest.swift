//
//  LocalNotificationViewModelUnitTest.swift
//  GamioTests
//
//  Created by Gokberk Ozcan on 17.12.2022.
//

import XCTest

final class LocalNotificationViewModelUnitTest: XCTestCase {

    var viewModel: LocalNotificationViewModel!
    

    override func setUpWithError() throws {
        viewModel = LocalNotificationViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSetNotification() throws {
        
        XCTAssertEqual(viewModel.setNotification(), true)
    }
    func testRemoveNotification() throws {
        
        XCTAssertEqual(viewModel.removeNotification(), true)
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
