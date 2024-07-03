//
//  LightWindowView.swift
//  LightAndAction
//
//  Created by BOURACHOT Guillaume on 03.07.2024.
//
//

import SwiftUI

struct LightWindowView: View {
    
    @StateObject private var viewModel: LightWindowViewModel
    let favoritableIdentifier: Identifier
    
    init(favoritableIdentifier: Identifier) {
        self._viewModel = StateObject(wrappedValue: LightWindowViewModel(identifier: favoritableIdentifier)) 
        self.favoritableIdentifier = favoritableIdentifier
    }
    
    var body: some View {
        HStack {
            Spacer().frame(width: 10)
            VStack {
                Text("Light window \(favoritableIdentifier)")
                Text("Intensity: \(viewModel.lightItem.intensity)")
                Slider(value: $viewModel.lightItem.intensity, 
                       in: 0...1,
                       onEditingChanged: {_ in 
                    self.viewModel.saveNewValues()
                })
            }
            Spacer().frame(width: 10)
        }
        .padding()
    }
}

#Preview {
    LightWindowView(favoritableIdentifier: "Light-1")
}
