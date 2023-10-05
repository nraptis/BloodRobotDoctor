//
//  SliderRow.swift
//  Macintosh
//
//  Created by Screwy Uncle Louie on 10/4/23.
//

import SwiftUI

struct SliderRow: View {

    let title: String
    @State var value: Float
    let updateHandler: (Float) -> Void
    let minValue: Float
    let maxValue: Float
    
    init(title: String,
         value: Float,
         minValue: Float,
         maxValue: Float,
         updateHandler: @escaping (Float) -> Void) {
        _value = State(wrappedValue: value)
        self.title = title
        self.minValue = minValue
        self.maxValue = maxValue
        self.updateHandler = updateHandler
    }

    var body: some View {
        VStack {
            HStack {
                Text(title)
                Slider(value: $value, in: minValue...maxValue)
            }
        }
        .frame(height: 80.0)
        .background(RoundedRectangle(cornerRadius: 12.0).foregroundColor(.cyan))
        .onChange(of: value) {
            updateHandler(value)
        }
    }
}

#Preview {
    SliderRow(title: "Slider Row", value: 16.0, minValue: 0.0, maxValue: 10.0) { _ in
        
    }
}
