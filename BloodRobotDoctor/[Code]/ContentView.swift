//
//  ContentView.swift
//  BloodRobotDoctor
//
//  Created by Sports Dad on 9/28/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                MedicalSceneView(width: round(geometry.size.width),
                                 height: round(geometry.size.height))
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
