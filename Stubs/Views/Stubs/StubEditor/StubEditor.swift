//
//  AddConcertView.swift
//  Stubs
//
//  Created by christian on 6/8/23.
//

import MapKit
import SwiftUI
import SwiftData

struct StubEditor: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @Query var artists: [Artist]
    
    @State private var viewModel: ViewModel
    
    // MARK: Local concert for editing
    @State private var concertTemplate = Concert(
        artistName: "",
        venue: "",
        city: "",
        date: Date.now,
        iconName: StubStyle.icons.randomElement()!,
        accentColor: StubStyle.colors.randomElement()!,
        notes: "",
        venueLatitude: 0.0,
        venueLongitude: 0.0
    )
    @State private var addConcertFailed = false
    @State private var addConcertFailedAlert: Alert?
    @State private var debounceTimer: Timer?
    @State private var fetchedArtist: Artist?
    
    let addConcertTip: AddConcertTip
    let artistViewOptionsTip = ArtistsViewOptionsTip()
    
    // Returns true if any field is empty
    private var saveReady: Bool {
        !concertTemplate.artistName.isEmpty
        && !concertTemplate.venue.isEmpty
        && !concertTemplate.city.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                StubEditorStubPreview(concert: concertTemplate)
                StubEditorDetails(concert: concertTemplate)
                StubEditorIconSelector(iconName: $concertTemplate.iconName)
                StubEditorColorSelector(accentColor: $concertTemplate.accentColor)
                StubEditorNotes(concertNotes: $concertTemplate.notes)
            }
            .navigationTitle("Stub Editor")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        //viewModel.addConcert()
                    }
                    .disabled(!saveReady)
                }
            }
            
            //            .onChange(of: concertTemplate.artistName) {
            //                                // Invalidate existing timer
            //                                debounceTimer?.invalidate()
            //
            //
            //                                // Start a new timer
            //                                debounceTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { _ in
            //                                    print("StubEditor: concert.artistName has changed")
            //                                    print("StubEditor: now searching for \(concertTemplate.artistName)")
            //                                    artistService.search(for: concertTemplate.artistName)
            //                                })
            //            }
            
            
            .onChange(of: viewModel.artistService.searchResponse) { _, response in
                if let artist = response.first {
                    print("StubEditor: artist search response received.")
                    
                    fetchedArtist = artist
                    print("StubEditor: artist binding value has been updated.")
                    
                    viewModel.fetchImageData(from: artist.artistImageURL ?? "") { data in
                        fetchedArtist?.artistImageData = data
                        print("StubEditor: imageData fetched")
                        print("StubEditor: Data: \(String(describing: data))")
                    }
                    
                    viewModel.fetchImageData(from: artist.bannerImageURL ?? "") { data in
                        fetchedArtist?.bannerImageData = data
                    }
                    
                } else {
                    print("StubEditorDetails: artist search failed.")
                }
            }
        }
        .alert(isPresented: $addConcertFailed) {
            addConcertFailedAlert ?? Alert(title: Text("Error"))
        }
    }
}




extension StubEditor {
    
    @Observable
    class ViewModel {
        var artists: [Artist]
        var concerts: [Concert]
        var modelContext: ModelContext

        let artistService = ArtistService()
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
            fetchData()
        }
        
        func fetchImageData(
            from urlString: String,
            completion: @escaping (Data?) -> Void
        ) {
            guard let url = URL(string: urlString) else {
                completion(nil)
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    completion(nil)
                    return
                }
                completion(data)
            }
            task.resume()
        }
        
        
        // MARK: addConcert()

        @MainActor
        func addConcert(_ concert: Concert) {
            Task {
                do {
                    // Attempt to get coordinates for the new concert
                    let coordinates = try await getCoordinates(for: concert)
                    
                    // Update concert details with retrieved coordinates
                    concert.venueLatitude = coordinates.latitude
                    concert.venueLongitude = coordinates.longitude
                    
                    // Create a new Concert object
                    let newConcert = Concert(
                        artistName: concert.artistName,
                        venue: concert.venue,
                        city: concert.city,
                        date: concert.date,
                        iconName: concert.iconName,
                        accentColor: concert.accentColor,
                        notes: concert.notes,
                        venueLatitude: concert.venueLatitude,
                        venueLongitude: concert.venueLongitude
                    )
                    
                    // Search for artist by name in the `artists` array
                    if let existingArtist = artists.first(where: { $0.artistName == newConcert.artistName }) {
                        // If an artist with the same name is found, associate it with the new concert
                        newConcert.artist = existingArtist
                    } else {
                        // If no artist is found, search for it using the artistService
                        try await artistService.search(for: concert.artistName)
                        if let fetchedArtist = artistService.searchResponse[0] {
                            newConcert.artist = fetchedArtist
                        }
                    }
                    
                    // Insert updated concert details into model context
                    modelContext.insert(newConcert)
                    try modelContext.save()
                    
                    // Invalidate the tip and add an event counter
                    addConcertTip.invalidate(reason: .actionPerformed)
                    await ArtistsViewOptionsTip.addArtistEvent.donate()
                    
                    dismiss()
                } catch {
                    // Handle error
                    print(error.localizedDescription)
                    
                    let alert = Alert(
                        title: Text("Save Error"),
                        message: Text(error.localizedDescription),
                        dismissButton: .default(Text("OK"))
                    )
                    addConcertFailedAlert = alert
                    addConcertFailed = true
                }
            }
            fetchData()
        }
        
        // MARK: - getCoordinates(for:)
        /**
         Retrieves coordinates for given concert details.
         
         - Parameters:
         - concert: `Concert`
         - Returns: Tuple containing latitude and longitude of the concert venue.
         
         Uses MKLocalSearch to query based on concert venue and city. Converts query response to geographic coordinates.
         Throws error if unable to find location or extract coordinates from response.
         */
        private func getCoordinates(
            for concert: Concert
        ) async throws -> (latitude: Double, longitude: Double) {
            
            // Construct search request using concert details
            let request = MKLocalSearch.Request()
            let query = concert.venue + " venue " + concert.city
            
            request.naturalLanguageQuery = query
            request.resultTypes = .pointOfInterest
            
            // Debug print for query search
            print("searching for \(query)")
            
            // Initialize and start search
            let search = MKLocalSearch(request: request)
            let response = try? await search.start()
            
            // Ensure coordinates are available, else throw error
            guard let coordinates = response?.mapItems.first?.placemark.coordinate else  {
                throw NSError(domain: "LocationError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unable to find location"])
            }
            
            // Return latitude and longitude as tuple
            return (
                latitude: coordinates.latitude,
                longitude: coordinates.longitude
            )
        }
        
        func fetchData() {
            do {
                let artistDescriptor = FetchDescriptor<Artist>(
                    sortBy: [SortDescriptor(\.artistName)]
                )
                let concertDescriptor = FetchDescriptor<Concert>(
                    sortBy: [SortDescriptor(\.artistName)]
                )
                concerts = try modelContext.fetch(concertDescriptor)
                artists = try modelContext.fetch(artistDescriptor)
            } catch {
                print("Fetch failed")
            }
        }
        
        
        
    }
}
