//
//  ArtistsView.swift
//  Stubs
//
//  Created by christian on 12/29/23.
//

// TODO: Find a way to load images in this view and pass to detail views. Currently artist images load here.

import SwiftUI
import SwiftData

struct ArtistsView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Namespace var namespace
    @Query var concerts: [Concert]
    
    @State private var artistImageWidth: CGFloat = 44
    @State private var listView = true
    @State private var searchPrompt = "Search Artists"
    @State private var searchText = ""
    @State private var sortOrder: SortOrder = .byNameAscending
    
    private var artists: [Artist] {
        var artists = [Artist]()
        
        for concert in concerts {
            artists.append(concert.artist ?? Artist())
        }
        
        let uniqueArtists = Set(artists)
        let sortedArists = Array(uniqueArtists).sorted {
            $0.artistName ?? "" < $1.artistName ?? ""
        }
        return sortedArists
    }
    
    private var filteredArtists: [Artist] {
        if searchText.isEmpty {
            return artists
        } else {
            return artists.filter { artist in
                if let artistName = artist.artistName {
                    return artistName.lowercased().contains(searchText.lowercased())
                } else {
                    return false
                }
            }
        }
    }
    
    private var sortedArtists: [Artist] {
        switch sortOrder {
        case .byNameAscending:
            return filteredArtists.sorted(by: {$0.artistName ?? ""  < $1.artistName ?? ""})
        case .byNameDescending:
            return filteredArtists.sorted(by: {$0.artistName ?? ""  > $1.artistName ?? ""})
        default:  return filteredArtists
        }
    }
    
    private var groupedArtists: [String: [Artist]] {
        Dictionary(grouping: sortedArtists) { $0.artistName?.first?.uppercased() ?? "#" }
    }
    
    private var sortedKeys: [String] {
        
        switch sortOrder {
        case .byNameDescending:
            groupedArtists.keys.sorted().reversed()
            
        default:
            groupedArtists.keys.sorted()
            
        }
    }
    
    
    private let artistsViewOptionsTip = ArtistsViewOptionsTip()
    
    var body: some View {
        ZStack {
            
            NavigationStack {
                ScrollView {
                    if listView {
                        ArtistListView(
                            groupedArtists: groupedArtists,
                            sortedKeys: sortedKeys,
                            listView: listView,
                            namespace: namespace
                        )
                        
                    } else {
                        ArtistGridView(
                            artists: sortedArtists,
                            listView: listView,
                            namespace: namespace
                        )
                    }
                }
                .navigationTitle("Artists")
                .searchable(
                    text: $searchText,
                    prompt: searchPrompt
                )
                .toolbar {
                    ToolbarItem {
                        ArtistMenuLabel(
                            artistImageWidth: $artistImageWidth,
                            listView: $listView,
                            sortOrder: $sortOrder
                        )
                    }
                    
                }
                .tint(.primary)
            }
        }
        
    }

}