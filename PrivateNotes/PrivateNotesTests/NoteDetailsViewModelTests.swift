//
//  NoteDetailsViewModelTests.swift
//  PrivateNotesTests
//
//  Created by Xinghou.Liu on 14/06/2024.
//

import XCTest
import Combine
@testable import PrivateNotes

final class NoteDetailsViewModelTests: XCTestCase {

    var viewModel: NoteDetailsViewModel!
    var cancelables: [AnyCancellable] = []
    var mockNote: Note!
    let mockNoteTitle: String = "12345"
    
    override func setUpWithError() throws {
        mockNote = Note.mock()
        mockNote.title = mockNoteTitle
        
        viewModel = NoteDetailsViewModel(presentType: .readOnly(mockNote),
                                         viewContext: PersistenceController.preview.container.viewContext)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        cancelables = []
    }

    func testSave() {
        
        // given
        let newTitle = "new-note-title"
        let newContent = "new-note-content"
        var returnNote: Note?
        
        viewModel.noteContent = newContent
        viewModel.noteTitle = newTitle
        
        let exp = expectation(description: "Saving Note")
        
        viewModel.$presentType.sink { newValue in
            switch newValue {
            case .didSave(let note):
                returnNote = note
                exp.fulfill()
            default:
                break
            }
        }
        .store(in: &cancelables)
        
        //when
        viewModel.save()
        
        wait(for: [exp], timeout: 5)
        
        XCTAssertNotNil(returnNote)
        XCTAssertEqual(returnNote?.title, newTitle)
        XCTAssertEqual(returnNote?.content, newContent)
    }
}
