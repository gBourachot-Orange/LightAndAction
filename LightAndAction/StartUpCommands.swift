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
            //SetUpOSC()
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

struct SetUpOSC: Command {
    func execute() {
        for message in OSCManager.OSCMessageType.allCases {
            OSCManager.shared.send(0.5, identifier: "", for: message)
        }        
    }
}
