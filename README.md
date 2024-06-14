# Private Notes

A simple SwiftUI (with CoreData) app to handle notes taking with CRUD (Create, Read, Update & Delete) functios in MVVM-C pattern.

## Notes
* Due to the limitation of device, this app can only be tested with iOS 16.6 on a device,
* In 'NoteListView', If the list of notes is not showing, please make sure you have created at least one note and try to click the 'Refresh' button, this is a navigation issue I am yet to fix. 
* In the 'NoteDetailsView' there seams to be an issue with TextField from SwiftUI where the keyboard is getting hidden automatically, this should work well on a device running iOS 17.0+.
* Due to time limitation, only the 2 of the viewModels' functions are unit tested. More tests can be achieve by following the same pattern. 

## How to run 
Download the codes and double click the project file inside 'PrivateNotes' foler, then make sure the deployment target is iOS 16.6 or higher and you can run on device or simulator.

* To Create a new note, please tap the '+' button at the top bar of the main screen
* To Update a note, just select it and tap the 'Edit' button from the next screen, then tap 'Save' after editing
* To Delete a note, just swipe to left on the cell from the note list
* If the note list is not showing, please tap the 'Refresh' button


## Requirements

* Xcode 15.2 (or later)
* Deployment target iOS 16.6
* Please test on a device for proper Biomatric functions


## Tech stack

* SwiftUI
* CoreData
* MVVM-C
* Biomatric authentication
* TDD

 
