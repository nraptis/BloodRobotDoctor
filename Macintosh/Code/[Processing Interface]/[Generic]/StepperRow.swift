//
//  StepperRow.swift
//  Macintosh
//
//  Created by Sports Dad on 10/4/23.
//

import SwiftUI

struct StepperRow: View {
    let title: String
    @State var value: Int
    let updateHandler: (Int) -> Void
    let minValue: Int
    let maxValue: Int
    let step: Int
    
    init(title: String,
         value: Int,
         minValue: Int,
         maxValue: Int,
         step: Int,
         updateHandler: @escaping (Int) -> Void) {
        _value = State(wrappedValue: value)
        self.title = title
        self.minValue = minValue
        self.maxValue = maxValue
        self.step = step
        self.updateHandler = updateHandler
    }

    var body: some View {
        VStack {
            HStack {
                Text(title)
                Stepper("abw", value: $value, in: minValue...maxValue, step: step)
                Text("v: \(value)")
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
    StepperRow(title: "Stepper Row",
               value: 5,
               minValue: 0,
               maxValue: 60,
               step: 1) { _ in
        
    }
}
