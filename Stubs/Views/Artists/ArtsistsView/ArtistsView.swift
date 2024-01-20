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
    
    @Query var concerts: [Concert]
    @Namespace var namespace
    
    @State private var model = ArtistService()
    
    @State private var listView = false
    
    @State private var artistImageWidth: CGFloat = 75
    
    @State private var searchPrompt = "Search Artists"
    @State private var searchText = ""
    
    private let columns = [
        GridItem(.adaptive(minimum: 120))
    ]
    
    private var tileBackgroundColor: Color {
        if colorScheme == .dark {
            return Color(white: 0.2)
        } else {
            return Color(white: 0.95)
        }
    }
    
    private var shadowColor: Color {
        if colorScheme == .dark {
            return Color(white: 0.9)
        } else {
            return .secondary
        }
    }
    
    private var artists: [Artist] {
        var artists = [Artist]()
        
        for concert in concerts {
            artists.append(concert.artist)
        }
        
        let uniqueArtists = Set(artists)
        let sortedArists = Array(uniqueArtists).sorted { $0.artistName ?? "" < $1.artistName ?? "" }
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
    
    
    var body: some View {
        NavigationStack {
            
            ScrollView {
                
                
                
                if listView {
                    
                    VStack {
                        ForEach(filteredArtists, id: \.artistID){ artist in
                            NavigationLink {
                                ArtistDetailView(artist: artist)
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundStyle(tileBackgroundColor)
                                        .shadow(color: shadowColor, radius: 2)
                                    
                                    // use smallest, unused piece of unique data as reference
                                        .matchedGeometryEffect(id: artist.artistImageURL, in: namespace)
                                    
                                    HStack {
                                        ZStack {
                                            Circle()
                                                .foregroundStyle(.gray)
                                                .frame(width: artistImageWidth)
                                            
                                            if let data = artist.artistImageData {
                                                Image(uiImage: UIImage(data: data) ?? UIImage())
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: artistImageWidth)
                                                    .clipShape(Circle())
                                                    .shadow(color: .primary.opacity(0.5), radius: 3)
                                            }
                                            
                                        }
                                        .matchedGeometryEffect(id: artist.artistID, in: namespace)
                                        
                                        .padding(.trailing, 8)
                                        
                                        Text(artist.artistName ?? "")
                                            .font(.headline)
                                            .multilineTextAlignment(.center)
                                            .lineLimit(3)
                                        
                                        
                                        
                                        StubCountIndicator(artist: artist)
                                            .matchedGeometryEffect(id: artist.bannerImageURL, in: namespace)
                                        Text(stubCount(for: artist) > 1 ? "Stubs" : "Stub")
                                            .foregroundStyle(.secondary)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundStyle(.secondary.opacity(0.5))
                                            .frame(width: 10)
                                            
                                    }
                                    .padding(.horizontal)
                                    .padding(.vertical, 10)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                        }
                    }
                    .searchable(text: $searchText, prompt: searchPrompt) // Search bar

                    .padding(.horizontal)
                    .padding(.bottom, 100)
                    
                } else {
                    LazyVGrid(columns: columns) {
                        ForEach(filteredArtists, id: \.artistID){ artist in
                            
                            NavigationLink {
                                ArtistDetailView(artist: artist)
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundStyle(tileBackgroundColor)
                                        .shadow(color: shadowColor, radius: 2)
                                    // use smallest, unused piece of unique data as reference
                                        .matchedGeometryEffect(id: artist.artistImageURL, in: namespace)
                                    
                                    
                                    VStack {
                                        ZStack(alignment: .bottomTrailing) {
                                            ZStack {
                                                Circle()
                                                    .foregroundStyle(.gray)
                                                    .frame(width: artistImageWidth)
                                                
                                                if let data = artist.artistImageData {
                                                    Image(uiImage: UIImage(data: data) ?? UIImage())
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: artistImageWidth)
                                                        .clipShape(Circle())
                                                        .shadow(color: .primary.opacity(0.5), radius: 3)
                                                }
                                            }
                                            .matchedGeometryEffect(id: artist.artistID, in: namespace)
                                            
                                            StubCountIndicator(artist: artist)
                                                .offset(x: 4, y: 4)
                                                .matchedGeometryEffect(id: artist.bannerImageURL, in: namespace)
                                        }
                                        
                                        
                                        Spacer()
                                        
                                        Text(artist.artistName ?? "")
                                            .font(.headline)
                                            .multilineTextAlignment(.center)
                                            .lineLimit(3)
                                        
                                        Spacer()
                                    }
                                    .padding([.top, .horizontal])
                                }
                            }
                            .frame(minHeight: 150)
                            
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 100)
                    .searchable(text: $searchText, prompt: searchPrompt) // Search bar

                }
            }
            
            
            .navigationTitle("Artists")
            .toolbar {
                ToolbarItem {
                    Button {
                        withAnimation(.smooth(extraBounce: 0.2)) {
                            setImageWidth()
                            listView.toggle()
                        }
                    } label: {
                        Label(
                            "Toggle List View",
                            systemImage: listView
                            ? "square.grid.2x2"
                            : "list.bullet"
                        )
                    }
                }
            }
        }
        
    }
    
    private func stubCount(for artist: Artist) -> Int {
        var count = 0
        
        for concert in concerts {
            if concert.artistName.lowercased() == artist.artistName?.lowercased() {
                count += 1
            }
        }
        
        return count
    }
    
    private func setImageWidth() {
        if artistImageWidth == 75 {
            artistImageWidth = 44
        } else {
            artistImageWidth = 75
        }
    }
}