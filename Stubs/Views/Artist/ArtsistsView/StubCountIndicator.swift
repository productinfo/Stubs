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
    
    private var gradientColors: [Color] {
            switch stubCount {
            case 1: // 1 Stub
                return [.white, .green, .green, .gray]
            case 2: // 2 Stubs
                return [.white, .yellow, .yellow, .gray]
            default: // 3+ Stubs
                return [.white, .blue, .blue, .gray]
            }
        }
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 25)
                .foregroundStyle(
                    LinearGradient(
                        colors: gradientColors,
                        startPoint: .topLeading,
                        endPoint:  .bottomTrailing
                    )
                
                )
            Text(String(stubCount))
                .foregroundStyle(.white)
        }
        //.offset(x: 4, y: 4)
    }
}

