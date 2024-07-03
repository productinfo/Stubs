//
//  ContentView.swift
//  StubsMac
//
//  Created by christian on 6/29/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var concerts: [Concert]
    @Query var artists: [Artist]
    @State private var selectedTab: TabBarItem? = .stubs
    @State private var selectedConcert: Concert? = nil
    @State private var selectedArtist: Artist? = nil
    
    
    var body: some View {
        NavigationSplitView {
            SidebarView(selection: $selectedTab)
        } content: {
            switch selectedTab {
            case .stubs:
                List(concerts, selection: $selectedConcert) { concert in
                    StubCollectionRowLabel(concert: concert)
                        .padding(.vertical, 6)
                        .tag(concert)
                        .contextMenu {
                            Button("Delete Concert") {
                                delete(concert)
                            }
                        }
                }
            case .artists:
                List(artists) { artist in
                    HStack {
                        Image(nsImage: NSImage(data: artist.artistImageData ?? Data())!)
                        Text(artist.artistName ?? "")
                    }
                }
            case .venues:
                Text("Venues")
            case nil:
                Text("Select a tab")
            }
        } detail: {
            switch selectedTab {
            case .stubs:
                StubDetailViewMac(concert: selectedConcert ?? Concert())
            case .artists:
                Text("Artist Detail")
            case .venues:
                Text("Venue Detail")
            case nil:
                Text("Select a tab")
            }
        }
        .toolbar {
            ToolbarItem {
                Button {
                    addSampleConert()
                } label: {
                    Label("Add Concert", systemImage: "plus")
                }
                .keyboardShortcut(KeyEquivalent("n"), modifiers: [.command])
            }
        }
    }
    
    private func addSampleConert() {
        let artistName = DebugData.artists.randomElement()!
        let venue = DebugData.venues.randomElement()!
        let notes = DebugData.notes.randomElement()!
        let color = ["red", "orange", "yellow", "purple", "green", "blue"].randomElement()!
        let iconName = StubStyle.icons.randomElement()!
        
        let concert = Concert(
            artistName: artistName,
            venue: venue.name,
            city: venue.city,
            iconName: iconName,
            accentColor: color,
            notes: notes,
            venueLatitude: venue.latitude,
            venueLongitude: venue.longitude
        )
        modelContext.insert(concert)
    }
    
    private func delete(_ concert: Concert) {
        modelContext.delete(concert)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Concert.self, inMemory: true)
}
