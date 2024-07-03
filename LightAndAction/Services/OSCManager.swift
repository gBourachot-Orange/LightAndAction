//
//  OSCManager.swift
//  LightAndAction
//
//  Created by BOURACHOT Guillaume on 03.07.2024.
//

import Foundation
import OSCKit

protocol OSCManagerLogic {
    func send(_ value: Float16, identifier: String, for message: OSCManager.OSCMessageType)
}

class OSCManager {
    static let shared: OSCManagerLogic = OSCManager()
    
    private let oscClient = OSCClient()
    private let oscServer: OSCServer
    private let serverPort: UInt16 = 8888
    private let remoteIP: String = "192.168.144.223"
    
    private init() {
        oscServer = OSCServer(port: serverPort)
        oscServer.setHandler { message, timeTag in
            print(message, "with time tag:", timeTag)
        }
        // oscServer.isPortReuseEnabled = true
        do { try oscServer.start() } catch { print(error) }
        
        // setup client
        
        // oscClient.isPortReuseEnabled = true
        // oscClient.isIPv4BroadcastEnabled = true
        do { try oscClient.start() } catch { print(error) }
    }
    
    deinit {
        oscServer.stop()
    }
    
    enum OSCMessageType: String, CaseIterable {
        case blue = "B1"
        case crossFade = "C1"
        case dimmer = "D1"
        case green = "G1"
        case temperature = "K1"
        case red = "R1"
    }
}

extension OSCManager: OSCManagerLogic {
    func send(_ value: Float16, identifier: String, for message: OSCManager.OSCMessageType) {
        try? oscClient.send(
            .message("/\(message.rawValue)", values: [value]),
            to: remoteIP, // remote IP address or hostname
            port: serverPort // standard OSC port but can be changed
        )
        print("Message sent", message.rawValue, value)
    }
}
