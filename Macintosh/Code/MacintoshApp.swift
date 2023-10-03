//
//  MacintoshApp.swift
//  Macintosh
//
//  Created by Sports Dad on 10/1/23.
//

import SwiftUI

@main
struct MacintoshApp: App {
    let controlInterfaceViewModel = ControlInterfaceViewModel()
    var body: some Scene {
        WindowGroup {
            AppContainerView(appWidth: ApplicationController.shared.appWidth,
                             appHeight: ApplicationController.shared.appHeight,
                             toolbarHeight: ApplicationController.shared.toolbarHeight,
                             controlInterfaceViewModel: controlInterfaceViewModel)
            
        }
    }
}
