//
//  LightWindowView.swift
//  LightAndAction
//
//  Created by BOURACHOT Guillaume on 03.07.2024.
//
//

import SwiftUI

struct LightWindowView: View {
    
    @EnvironmentObject private var viewModel: LightWindowViewModel
    
    var body: some View {
        HStack {
            Spacer().frame(width: 10)
            VStack {
                Text("Light window \(viewModel.lightItem.identifier)")
                Text(viewModel.lightItem.intensity,
                     format: .percent.precision(.fractionLength(0)))
                Slider(value: $viewModel.sliderValue,
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
    LightWindowView()
        .environmentObject(LightWindowViewModel(identifier: "Light-1"))
}
