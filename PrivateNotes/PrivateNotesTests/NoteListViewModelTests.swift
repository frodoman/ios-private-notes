//
//  NoteListViewModelTests.swift
//  PrivateNotesTests
//
//  Created by X_coder on 14/06/2024.
//

import XCTest
import Combine
@testable import PrivateNotes

final class NoteListViewModelTests: XCTestCase {

    var viewModel: NoteListViewModel!
    var cancelables: [AnyCancellable] = []
    
    override func setUpWithError() throws {
        viewModel = NoteListViewModel(viewContext: PersistenceController.preview.container.viewContext)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testFetchNotes() throws {
        
        // given
        let exp = expectation(description: "Fetching notes")
        var validNotes: [Note] = []
        
        viewModel.$status.sink { newStatus in
            if case .ready(let notes) = newStatus {
                validNotes = notes
                exp.fulfill()
            }
        }
        .store(in: &cancelables)
        
        // when
        viewModel.fetchNotes()
        
        // then
        wait(for: [exp], timeout: 2)
        
        XCTAssertTrue(validNotes.count > 0)
    }
}
