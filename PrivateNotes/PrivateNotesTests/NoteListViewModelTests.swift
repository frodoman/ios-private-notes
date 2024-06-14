//
//  NoteListViewModelTests.swift
//  PrivateNotesTests
//
//  Created by Xinghou.Liu on 14/06/2024.
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
        viewModel = nil
        cancelables = []
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
    
    func testDeleteNote() throws {
        
        // given
        let exp = expectation(description: "Deleting notes")
        let indexSetToDelete: IndexSet = [0, 1]
        var deletedSet: IndexSet = []

        viewModel.status = .ready(Note.mockNotes())
        
        viewModel.$status.sink { newStatus in

            switch newStatus {
            case .deleted(let indexes):
                deletedSet = indexes
                exp.fulfill()
                
            default:
                break
            }
        }
        .store(in: &cancelables)
        
        // when
        viewModel.deleteNote(offsets: indexSetToDelete)
        
        // then
        wait(for: [exp], timeout: 2)
        
        XCTAssertTrue(deletedSet == indexSetToDelete)
        
    }
}
