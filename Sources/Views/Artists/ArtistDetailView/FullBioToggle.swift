//
//  FullBioToggle.swift
//  Stubs
//
//  Created by christian on 2/29/24.
//

import SwiftUI

struct FullBioToggle: View {
    @Binding var showingFullBio: Bool
    @Environment(\.colorScheme) var colorScheme
    
    private var fontColor: Color {
        if !showingFullBio && colorScheme == .light {
          return .white
        } else {
            return .secondary
        }
    }
    
    var body: some View {
        
            HStack {
                Text(
                    showingFullBio
                    ? "Less"
                    : "More"
                )
                
//                Image(
//                    systemName: showingFullBio
//                    ? "chevron.up"
//                    : "chevron.down"
//                )
            }
            .font(.caption.bold())
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(showingFullBio ? .all : .horizontal)
            .onTapGesture {
                withAnimation(.smooth){
                    showingFullBio.toggle()
                }
            }
    }
}
