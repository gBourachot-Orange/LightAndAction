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
            VStack(spacing: 20) {
                Button("SetUp Light"){
                    Task {
                        if let lightItem = try? await self.viewModel.newLight() {
                            openWindow(id: "Light", value: lightItem.favoritableId)
                        }
                    }
                }
                lightList
            }
        }
        .padding()
    }

    private var lightList: some View {
        List {
            ForEach(viewModel.lightList, id: \.favoritableId) { lightWindowItem in
                LightViewCell(lightItem: lightWindowItem, viewModel: viewModel)
            }
        }
    }
}

#Preview {
    MainView()
}
