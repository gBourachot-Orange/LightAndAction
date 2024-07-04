//
//  OSCManager.swift
//  LightAndAction
//
//  Created by BOURACHOT Guillaume on 03.07.2024.
//

import Foundation
import OSCKit

protocol OSCManagerLogic {
    func send(_ value: Float16, for message: OSCManager.OSCMessageType)
    func resetAllLights()
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
    
    enum OSCMessageType {
        case blue(Int)
        case crossFade(Int)
        case dimmer(Int)
        case green(Int)
        case temperature(Int)
        case red(Int)
        
        case pan
        case tilt
        case cyan
        case magenta
        case yellow
        case cct
        case cf
        case zoom
        case focus
        case dim
        
        var rawValue: String {
            switch self {
            case .blue(let identifier):
                return "B\(identifier)"
            case .crossFade(let identifier):
                return "C\(identifier)"
            case .dimmer(let identifier):
                return "D\(identifier)"
            case .green(let identifier):
                return "G\(identifier)"
            case .temperature(let identifier):
                return "K\(identifier)"
            case .red(let identifier):
                return "R\(identifier)"
            case .pan:
                return "Pa"
            case .tilt:
                return "Ti"
            case .cyan:
                return "CY"
            case .magenta:
                return "Ma"
            case .yellow:
                return "Ye"
            case .cct:
                return "Ct"
            case .cf:
                return "Cx"
            case .zoom:
                return "Zo"
            case .focus:
                return "Fo"
            case .dim:
                return "Di"
            }
        }
    }
}

extension OSCManager: OSCManagerLogic {
    func send(_ value: Float16, for message: OSCManager.OSCMessageType) {
        try? oscClient.send(
            .message("/\(message.rawValue)", values: [value]),
            to: remoteIP, // remote IP address or hostname
            port: serverPort // standard OSC port but can be changed
        )
        print("Message sent", message.rawValue, value)
    }
    
    func resetAllLights() {
        for number in 1...4 {
            self.send(0, for: .blue(number))
            self.send(0, for: .crossFade(number))
            self.send(0, for: .dimmer(number))
            self.send(0, for: .green(number))
            self.send(0, for: .temperature(number))
            self.send(0, for: .red(number))
        }
        
        self.send(0, for: .pan)
        self.send(0, for: .tilt)
        self.send(0, for: .cyan)
        self.send(0, for: .magenta)
        self.send(0, for: .yellow)
        self.send(0, for: .cct)
        self.send(0, for: .cf)
        self.send(0, for: .zoom)
        self.send(0, for: .focus)
        self.send(0, for: .dim)
    }
}
