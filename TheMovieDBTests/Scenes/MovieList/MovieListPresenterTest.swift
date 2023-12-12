//
//  MovieListPresenterTest.swift
//  TheMovieDBTests
//
//  Created by Antonio Araez Moreno on 12/12/23.
//

import XCTest
@testable import TheMovieDB

@MainActor class MovieListPresenterTest: XCTestCase {

    var sut: MovieListPresenter!
    var sutDelegate: MovieListViewMock!
    var timeOut: TimeInterval = 2.0
    
    @MainActor override func setUpWithError() throws {
        sutDelegate = MovieListViewMock()
        sut = MovieListPresenter(viewController: sutDelegate)
    }

    @MainActor override func tearDownWithError() throws {
        sutDelegate = nil
        sut = nil
    }
    
    func test_GetNewMovieList() {
        sutDelegate.expDisplayMovies = expectation(description: "loading movie list")
        sut.currentPage = 20

        sut.getNewMovieList()
        
        waitForExpectations(timeout: timeOut)
        
        //Assertions
        XCTAssertNotNil(sut.movieList?.results, "MovieList didn't load any result")
        XCTAssertTrue(sutDelegate.displayMoviesCalled, "Movies didn't display")
        XCTAssertTrue(sut.currentPage == 1, "currentPage don't reset to 1")
    }
    
    /// setting listType reloads movie list
    func test_ListType() {
        sutDelegate.expDisplayMovies = expectation(description: "loading movie list")
        sut.setMovieListType(.nowPlaying)
        
        waitForExpectations(timeout: timeOut)

        //Assertions
        XCTAssertNotNil(sut.movieList?.results, "MovieList didn't load any result")
        XCTAssertTrue(sutDelegate.displayMoviesCalled, "Movies didn't display")
        XCTAssertTrue(sut.currentPage == 1, "currentPage don't reset to 1")
    }
    
    func test_LoadPage() {
        sutDelegate.expDisplayMovies = expectation(description: "loading movie list")
        sut.loadPage()
        
        waitForExpectations(timeout: timeOut)

        //Assertions
        XCTAssertNotNil(sut.movieList?.results, "MovieList didn't load any result")
        XCTAssertTrue(sutDelegate.displayMoviesCalled, "Movies didn't display")
        XCTAssertFalse(sut.currentPage == 1, "currentPage shouldn't be 1")
    }
}

class MovieListViewMock: MovieListDisplayLogic {
    
    var displayMoviesCalled = false
    var expDisplayMovies: XCTestExpectation?

    func displayMovies(_ displayMovies: [TheMovieDB.DisplayMovie], append: Bool) {
        displayMoviesCalled = true
        expDisplayMovies?.fulfill()
    }
}
