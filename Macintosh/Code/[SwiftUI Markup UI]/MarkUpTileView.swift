//
//  MarkUpTileView.swift
//  Macintosh
//
//  Created by Screwy Uncle Louie on 10/9/23.
//

import SwiftUI

struct MarkUpTileView: View {
    
    let slice: MedicalSceneSlice
    
    var body: some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: 32.0)
                .foregroundColor(Color.red.opacity(0.4))
                .frame(width: CGFloat(slice.width), height: CGFloat(slice.height))
            
            RoundedRectangle(cornerRadius: 32.0)
                .foregroundColor(Color.green.opacity(0.4))
                .frame(width: CGFloat(slice.width / 2.0), height: CGFloat(slice.height))
                .offset(x: 25.0)
        }
        
    }
}

#Preview {
    MarkUpTileView(slice: MedicalSceneSlice.preview)
}
