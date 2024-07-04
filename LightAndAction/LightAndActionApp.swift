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
            SideBarView()
        }.defaultSize(CGSize(width: 1000, height: 970))

        WindowGroup(id: "Light", for: Identifier.self) { $lightId in
            LightWindowView()
                .environmentObject(LightWindowViewModel(identifier: lightId!))
        }.defaultSize(CGSize(width: 200, height: 300))

        WindowGroup(id: "Camera", for: Identifier.self) { $cameraId in
            VideoPlayerView(favoritableIdentifier: cameraId!)
        }.defaultSize(CGSize(width: 800, height: 770))
         .windowStyle(.plain)
    }
}
