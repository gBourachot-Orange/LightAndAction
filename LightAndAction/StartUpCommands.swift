//
//  StartUpCommands.swift
//  LightAndAction
//
//  Created by BOURACHOT Guillaume on 03.07.2024.
//

import Foundation

public final class StartUpCommandBuilder {
    func build() -> [Command] {
        return [
            CleanUpSetUp(),
            ResetAllLights(),
        ]
    }
}

protocol Command {
    func execute()
}

struct CleanUpSetUp: Command {
    func execute() {
        DataRepository.shared.removeAll()
    }
}

struct ResetAllLights: Command {
    func execute() {
        OSCManager.shared.resetAllLights()
    }
}
