//
//  ActionButton.swift
//  Stubs
//
//  Created by christian on 6/16/23.
//

import SwiftUI

struct ActionButton: View {
    
    let titleKey: String
    let systemImage: String
    let highlightedImageName: String?
    let accentColor: Color
    
    @Binding var concert: Concert
    
    let action: () -> ()
    
    init(titleKey: String,
         systemImage: String,
         highlightedImageName: String? = nil,
         accentColor: Color,
         concert: Binding<Concert>,
         action: @escaping () -> ()) {
        self.titleKey = titleKey
        self.systemImage = systemImage
        self.highlightedImageName = highlightedImageName
        self.accentColor = accentColor
        self._concert = concert
        self.action = action
    }
    
    var body: some View {
        
        GeometryReader { geo in
            
            Button {
                
                action() // Perform given function
                
            } label: {
                
                HStack {
                    
                    // If concert is Favorite
                    Image(systemName: concert.isFavorite
                          // Display highlighted Image, nil coalescing to the non-optional default
                          ? highlightedImageName ?? systemImage
                          // Otherwise, display default image
                          : systemImage)
                    .renderingMode(.template)
                    .foregroundColor(accentColor)
                    
                    Text(titleKey)
                        .foregroundColor(.primary)
                                        
                }
                .font(.callout)
                .fontWeight(.semibold)
                .frame(width: geo.size.width * 0.8, height: geo.size.width * 0.3)
                
            }
            .position(x: geo.size.width / 2, y: geo.size.height / 2)
            .buttonStyle(.borderedProminent)
            .tint(.secondary.opacity(0.1))
            
        }
        .frame(maxHeight: 80)
        
    }
}

#Preview {
    ActionButton(titleKey: "Favorite",
                 systemImage: "checkmark",
                 highlightedImageName: "checkmark.seal",
                 accentColor: .yellow,
                 concert: .constant(SampleData.concerts[0]),
                 action: {}
    )
}
