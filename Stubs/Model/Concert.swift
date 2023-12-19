//
//  Item.swift
//  Stubs
//
//  Created by christian on 6/8/23.
//

import Foundation
import SwiftData


// MARK: Concert Type
// An object that represents a single concert

@Model
final class Concert {
    
    let uuid: UUID
    var artist: String
    var venue: String
    var city: String
    var date: Date
    var iconName: String
    var accentColor: String
    var notes: String
    var isFavorite: Bool
    
    init(uuid: UUID = UUID(),
         artist: String,
         venue: String,
         city: String,
         date: Date,
         iconName: String,
         accentColor: String,
         notes: String,
         isFavorite: Bool = false) {
        self.uuid = uuid
        self.artist = artist
        self.venue = venue
        self.city = city
        self.date = date
        self.iconName = iconName
        self.accentColor = accentColor
        self.notes = notes
        self.isFavorite = isFavorite
        
    }
}


