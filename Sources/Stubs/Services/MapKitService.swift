//
//  MapKitService.swift
//  Stubs
//
//  Created by christian on 3/21/24.
//

import Foundation
import MapKit

@Observable
class MapKitService {
    var latitude: Double = 0
    var longitude: Double = 0
    var mapSnapshotData: Data?
    
    func getCoordinates(
        for concert: Concert
    ) async throws -> (Double, Double) {
        let request = MKLocalSearch.Request()
        let query = concert.venue + " venue " + concert.city
        
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        
        let search = MKLocalSearch(request: request)
        let response = try? await search.start()
        
        guard let coordinates = response?.mapItems.first?.placemark.coordinate
        else  {
            throw MapKitServiceError.failedToFetchCoordinates
        }
        
        return (coordinates.latitude, coordinates.longitude)
    }
    
    func getMapSnapshot(
        for coordinates: (Double, Double)
    ) async throws -> Data?  {
        let options = MKMapSnapshotter.Options()
        
        options.camera = MKMapCamera(
            lookingAtCenter: CLLocationCoordinate2D(
                latitude: coordinates.0,
                longitude: coordinates.1
            ),
            fromDistance: 400,
            pitch: 70,
            heading: 0
        )
        options.mapType = .satelliteFlyover
        options.size = CGSize(width: 360, height: 150)
        options.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: coordinates.0,
                longitude: coordinates.1
            ),
            latitudinalMeters: 200,
            longitudinalMeters: 200
        )

        let snapshotter = MKMapSnapshotter(options: options)

        do {
            let snapshot = try await snapshotter.start()
            return snapshot.image.jpegData(compressionQuality: 1.0)
        } catch {
            throw MapKitServiceError.failedToFetchSnapshotData
        }
    }
 
}
