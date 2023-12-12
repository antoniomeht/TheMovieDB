//
//  MovieDetailPresenterTest.swift
//  TheMovieDBTests
//
//  Created by Antonio Araez Moreno on 12/12/23.
//

import XCTest
@testable import TheMovieDB

@MainActor class MovieDetailPresenterTest: XCTestCase {

    var sut: MovieDetailPresenter!
    var sutDelegate: MovieDetailViewMock!
    var timeOut: TimeInterval = 2.0
    
    @MainActor override func setUpWithError() throws {
        sutDelegate = MovieDetailViewMock()
        sut = MovieDetailPresenter(viewController: sutDelegate)
    }

    @MainActor override func tearDownWithError() throws {
        sutDelegate = nil
        sut = nil
    }
    
    func test_GetMovieDetail() {
        sutDelegate.expDisplayMovieDetail = expectation(description: "loading movie detail")
        sut.getMovieDetail(897087)
        
        waitForExpectations(timeout: timeOut)
        
        XCTAssertTrue(sut.movieDetails != nil, "movieDetails didn't load")
        XCTAssertTrue(sutDelegate.displayMovieDetailCalled, "Details didn't display")
    }
}

class MovieDetailViewMock: MovieDetailDisplayLogic {
    var displayMovieDetailCalled = false
    var expDisplayMovieDetail: XCTestExpectation?
    
    func displayMovieDetail(_ detail: TheMovieDB.DisplayMovieDetail) {
        displayMovieDetailCalled = true
        expDisplayMovieDetail?.fulfill()
    }
}
