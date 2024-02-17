//
//  StubCountIndicator.swift
//  Stubs
//
//  Created by christian on 1/15/24.
//

import SwiftUI
import SwiftData

struct StubCountIndicator: View {
    let artist: Artist
    
    @Environment(\.colorScheme) var colorScheme
    @Query var concerts: [Concert]

    private var stubCount: Int {
        var count = 0
        
        for concert in concerts {
            if concert.artistName.lowercased() == artist.artistName?.lowercased() {
                count += 1
            }
        }
        
        return count
    }
    
    private var shadowColor: Color {
        if colorScheme == .dark {
            return Color(white: 0.6)
        } else {
            return .secondary
        }
    }
    
    var body: some View {
        ZStack {
            
            StubShape()
                .frame(width: 42, height: 28)
                .foregroundStyle(
                    .ultraThickMaterial
                )
                .shadow(
                    color: shadowColor,
                    radius: 2,
                    y: 2
                )

            HStack {
                VerticalLineBoundary()
                Spacer()
                VerticalLineBoundary()
            }
            .frame(width: 32, height: 28)
            
            Text(String(stubCount))
                .foregroundStyle(.primary)
                .fontWeight(.semibold)

        }
    }
}

