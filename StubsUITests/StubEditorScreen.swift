//
//  StubEditorPageObject.swift
//  StubsUITests
//
//  Created by christian on 4/12/24.
//

import Foundation
import XCTest

class StubEditorScreen {
    let app: XCUIApplication
    let stubEditorNavBar: XCUIElement
    let saveButton: XCUIElement
    let cancelButton: XCUIElement
    let textFieldArtist: XCUIElement
    let textFieldVenue: XCUIElement
    let textFieldCity: XCUIElement
    let textFieldNotes: XCUIElement

    init(app: XCUIApplication) {
        self.app = app
        
        stubEditorNavBar = app.navigationBars["Stub Editor"]
        saveButton = stubEditorNavBar.buttons["Save"]
        cancelButton = stubEditorNavBar.buttons["Cancel"]

        let collection = app.collectionViews
        textFieldArtist = collection.textFields["Artist"]
        textFieldVenue = collection.textFields["Venue"]
        textFieldCity = collection.textFields["City"]
        textFieldNotes = collection.textFields["Notes"]
    }

    func fillOutForm(artist: String, venue: String, city: String) {
        textFieldArtist.tap()
        textFieldArtist.typeText(artist)
        textFieldVenue.tap()
        textFieldVenue.typeText(venue)
        textFieldCity.tap()
        textFieldCity.typeText(city)
    }
    
    func clearForm() {
        app.clearTextOnElement(textFieldArtist)
        app.clearTextOnElement(textFieldVenue)
        app.clearTextOnElement(textFieldCity)
    }
    
    func fillFormWithKnownGoodData() {
        fillOutForm(
            artist: "Green Day",
            venue: "Madison Square Garden",
            city: "New York"
        )
    }
    
    func fillFormWithEmptyValues() {
        fillOutForm(artist: " ", venue: " ", city: " ")
    }
}
