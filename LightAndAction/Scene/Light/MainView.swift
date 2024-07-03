//
//  MainView.swift
//  LightAndAction
//
//  Created by BOURACHOT Guillaume on 03.07.2024.
//
//

import SwiftUI
import RealityKit
import RealityKitContent

struct MainView: View {
    
    @StateObject private var viewModel = MainViewModel()
    @Environment(\.openWindow) private var openWindow
    
    var body: some View {
        return VStack {
            Text("Hello, world!")
            Button("SetUp Light"){
                Task {
                    if let lightItem = try? await self.viewModel.newLight() {
                        openWindow(id: "Light", value: lightItem.favoritableId)
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    MainView()
}
