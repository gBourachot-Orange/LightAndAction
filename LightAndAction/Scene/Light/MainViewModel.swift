//
//  MainViewModel.swift
//  LightAndAction
//
//  Created by BOURACHOT Guillaume on 03.07.2024.
//
//

import Foundation
import SwiftUI
import SwiftUIJoystick

protocol MainViewModelLogic: AnyObject {
    func newLight() async throws -> LightItem
    func resetLights() async
    func startTimer()
    func turnOnOff()
}

class MainViewModel: ObservableObject, MainViewModelLogic {

    @Published var lightList: [LightItem] = []
    @Published var monitor = JoystickMonitor()
    private var timer: Timer?
    private var isOn: Bool = false

    @MainActor
    func newLight() async throws -> LightItem {
        guard let lightItem = DataRepository.shared.newObject(type: .light) as? LightItem else {
            throw DataRepository.RepositoryError.typeConversionFailed
        }
        lightList.append(lightItem)
        return lightItem
    }
    
    func resetLights() {
        OSCManager.shared.resetAllLights()
    }
    
    @MainActor
    func startTimer() {
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
                OSCManager.shared.send(Float16(self.monitor.xyPoint.x), for: .pan)
                OSCManager.shared.send(Float16(self.monitor.xyPoint.y), for: .tilt)
            }
        }
    }
    
    @MainActor
    func turnOnOff() {
        if !isOn {
            OSCManager.shared.send(0, for: .cyan)
            OSCManager.shared.send(0, for: .magenta)
            OSCManager.shared.send(0, for: .yellow)
            OSCManager.shared.send(1, for: .cct)
            OSCManager.shared.send(0.5, for: .dim)
        } else {
            OSCManager.shared.send(0, for: .cyan)
            OSCManager.shared.send(0, for: .magenta)
            OSCManager.shared.send(0, for: .yellow)
            OSCManager.shared.send(1, for: .cct)
            OSCManager.shared.send(0, for: .dim)
        }
        isOn.toggle()
    }

    // Variables
}
