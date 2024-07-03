//
//  LightAndActionApp.swift
//  LightAndAction
//
//  Created by BOURACHOT Guillaume on 03.07.2024.
//

import SwiftUI

@main
struct LightAndActionApp: App {
    
    init() {
        // Perform any task on app launch
        StartUpCommandBuilder()
            .build()
            .forEach({ $0.execute() })
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }.defaultSize(CGSize(width: 50, height: 30))
            
        WindowGroup("Light", for: Identifier.self) { $lightId in
            LightWindowView(favoritableIdentifier: lightId!)
        }.defaultSize(CGSize(width: 50, height: 50))
    }
}
