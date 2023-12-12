//
//  SearchMoviePresenterTest.swift
//  TheMovieDBTests
//
//  Created by Antonio Araez Moreno on 12/12/23.
//

import XCTest
@testable import TheMovieDB

@MainActor class SearchMoviePresenterTest: XCTestCase {

    var sut: SearchMoviePresenter!
    var sutDelegate: SearchMovieViewMock!
    var timeOut: TimeInterval = 2.0
    
    @MainActor override func setUpWithError() throws {
        sutDelegate = SearchMovieViewMock()
        sut = SearchMoviePresenter(viewController: sutDelegate)
    }

    @MainActor override func tearDownWithError() throws {
        sutDelegate = nil
        sut = nil
    }
    
    func test_SearchTest() {
        sutDelegate.expDisplayMovieSearch = expectation(description: "loading movie list")
        sut.searchText(text: "Shrek")
        
        waitForExpectations(timeout: timeOut)
        
        XCTAssertTrue(sut.moviesResult?.results != nil, "Movies didn't load")
        XCTAssertTrue(sut.currentPage == 1, "currentPage didn't reset to 1")
        XCTAssertTrue(sutDelegate.displayMoviesCalled, "Movies didn't display")
    }
}

class SearchMovieViewMock: SearchMovieDisplayLogic {
    var searchTextDidChangedCalled = false
    var displayMoviesCalled = false
    var expDisplayMovieSearch: XCTestExpectation?
    
    func searchTextDidChanged(text: String?) {
        searchTextDidChangedCalled = true
    }
    
    func displayMovies(_ displayMovies: [TheMovieDB.DisplayMovie], append: Bool) {
        displayMoviesCalled = true
        expDisplayMovieSearch?.fulfill()
    }
    
}
