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
                MedicalSceneView(width: 900.0,
                                 height: 900.0)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .frame(width: 900.0, height: 900.0, alignment: .center)
    }
}

#Preview {
    ContentView()
}
