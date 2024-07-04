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
    @Environment(\.self) var environment

    @State private var lightColor = Color(.sRGB, red: 1, green: 1, blue: 1)
    @State private var resolvedColor: Color.Resolved?


    var body: some View {
        HStack {
            Spacer().frame(width: 10)
            VStack {
                Text("Light \(viewModel.lightItem.identifier)")
                    .font(.largeTitle)
                Slider(value: $viewModel.intensity,
                       in: 0...1,
                       onEditingChanged: {_ in 
                    self.viewModel.saveNewValues()
                })

                ColorPicker(selection: $lightColor,
                            supportsOpacity: false) {
                    Label("Select light color", systemImage: "paintpalette.fill")
                }
                    .onChange(of: lightColor, initial: true, setColors)
                    .padding()
            }
            Spacer().frame(width: 10)
        }
        .ornament(
            visibility: .visible,
            attachmentAnchor: .scene(.top),
            contentAlignment: .center
        ) {
            Text(viewModel.lightItem.intensity,
                 format: .percent.precision(.fractionLength(0)))
            .foregroundStyle(lightColor)
            .frame(width: 80)
            .padding()
            .glassBackgroundEffect()
            .font(.title)
            .bold()
            .fontWeight(.medium)
            .animation(.default, value: viewModel.lightItem.intensity)
            .contentTransition(.numericText())
        }

        .padding()
    }

    func setColors() {
        resolvedColor = lightColor.resolve(in: environment)
        guard let resolvedColor else { return }
        print("\(Float16(resolvedColor.red))")
        self.viewModel.red = Float16(resolvedColor.red)
        self.viewModel.blue = Float16(resolvedColor.blue)
        self.viewModel.green = Float16(resolvedColor.green)
    }
}

#Preview {
    LightWindowView()
        .environmentObject(LightWindowViewModel(identifier: "Light-1"))
}
