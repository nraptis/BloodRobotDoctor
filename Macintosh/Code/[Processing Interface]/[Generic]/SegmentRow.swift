//
//  SegmentRow.swift
//  Macintosh
//
//  Created by Screwy Uncle Louie on 10/5/23.
//

import SwiftUI

struct SegmentRow<Element: Identifiable & Hashable & CustomStringConvertible>: View {
    
    let title: String
    let choices: [Element]
    let updateHandler: (Element) -> Void
    private let count: Int
    @State private var selected: Element
    
    init(title: String,
         choices: [Element],
         selected: Element,
         updateHandler: @escaping (Element) -> Void) {
        
        
        //_selected = State(wrappedValue: selected)
        self.title = title
        self.updateHandler = updateHandler
        
        var __selected = choices[0]
        for choice in choices {
            //_names.append(node.name)
            //_items.append(node.item)
            if choice.id == selected.id {
                __selected = choice
            }
        }
        _selected = State(wrappedValue: __selected)
        print("initializing with selected as \(selected)")
        self.choices = choices
        self.count = choices.count
        print("selected is \(selected)")
    }

    var body: some View {
        VStack {
            HStack {
                Text(title)
                
                VStack {
                    Picker("What is your favorite color?", selection: $selected) {
                        
                        ForEach(choices) { choice in
                            Text(choice.description)
                                .tag(choice)
                        }
                        
                    }
                    .pickerStyle(.segmented)

                    //Text("Value: \(selected!)")
                    
                    
                }
                    
                
            }
        }
        .frame(height: 80.0)
        .background(RoundedRectangle(cornerRadius: 12.0).foregroundColor(.cyan))
        .onChange(of: selected) {
            print("OCO CALL")
            updateHandler(selected)
        }
    }
}

#Preview {
    SegmentRow(title: "Erosion Elements",
               choices: [ErosionElement.rect, ErosionElement.cross, ErosionElement.ellipse],
               selected: .ellipse) { _ in
        
    }
    
}
