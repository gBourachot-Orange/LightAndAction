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
import SwiftUIJoystick

struct MainView: View {
    
    @StateObject private var viewModel = MainViewModel()
    @Environment(\.openWindow) private var openWindow
    
    /// The monitor object to observe the user input on the Joystick in XY or Polar coordinates
    /// The width or diameter in which the Joystick will report values
    ///  For example: 100 will provide 0-100, with (50,50) being the origin
    private let dragDiameter: CGFloat
    /// Can be `.rect` or `.circle`
    /// Rect will allow the user to access the four corners
    /// Circle will limit Joystick it's radius determined by `dragDiameter / 2`
    private let shape: JoystickShape
    
    public init(width: CGFloat = 100, shape: JoystickShape = .rect) {
        self.dragDiameter = width
        self.shape = shape
    }

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button("SetUp Light"){
                    Task {
                        if let lightItem = try? await self.viewModel.newLight() {
                            openWindow(id: "Light", value: lightItem.favoritableId)
                        }
                    }
                }
                Button("Activate the Projecter"){
                    self.viewModel.resetLights()
                    self.viewModel.startTimer()
                }
                Button("Turn on/off"){
                    self.viewModel.turnOnOff()
                }
            }
            .padding()
            lightList
        }
        .ornament(attachmentAnchor: .scene(.trailing)) {
            Joystick(monitor: viewModel.monitor, width: 150)
                .padding()
        }
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
