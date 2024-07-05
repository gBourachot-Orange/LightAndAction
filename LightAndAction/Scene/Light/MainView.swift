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
    @State var isProjectorVisible: Visibility = .hidden
    @State var isProjectorTurnedOn = false

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
                    withAnimation {
                        isProjectorVisible = .visible
                    }
                }
            }
            .padding()
            lightList
        }
        .ornament(visibility: isProjectorVisible, attachmentAnchor: .scene(.trailing)) {
            sideProjectorView
        }
    }

    private var sideProjectorView: some View {
        
        return HStack {
            Spacer(minLength: 350)
            Rectangle()
                .foregroundColor(.clear)
                .glassBackgroundEffect()
                .frame(
                    width: 300,
                    height: 400
                )
                .overlay {
                    VStack(spacing: 25) {
                        Text("Projector")
                            .font(.title)
                            .bold()
                        Joystick(monitor: viewModel.monitor, width: 150)
                        Toggle("Turn On/Off the light", isOn: $isProjectorTurnedOn)
                            .padding()
                        .onChange(of: isProjectorTurnedOn) {
                            self.viewModel.turnOnOff()
                        }
                    }
                }
        }
        .rotation3DEffect(.degrees(-30), axis: .y)
    }

    private var lightList: some View {
        List {
            ForEach(viewModel.lightList, id: \.favoritableId) { lightWindowItem in
                LightViewCell(lightItem: lightWindowItem, viewModel: viewModel)
            }
        }
        .overlay {
            if viewModel.lightList.isEmpty {
                ContentUnavailableView {
                        Label("Empty Lights", systemImage: "light.strip.2.fill")
                } description: {
                    Text("No lights added yet ... 💡")
                }

            }
        }
    }
}

#Preview {
    MainView()
}
