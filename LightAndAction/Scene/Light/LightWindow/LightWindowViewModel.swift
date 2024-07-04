//
//  LightWindowViewModel.swift
//  LightAndAction
//
//  Created by BOURACHOT Guillaume on 03.07.2024.
//
//

import Foundation
import Combine

protocol LightWindowViewModelLogic: AnyObject {
    func saveNewValues() async
    func setLightValue() async
}

class LightWindowViewModel: ObservableObject, LightWindowViewModelLogic {
    
    // Variables
    @Published var lightItem: LightItem
    let didChange = PassthroughSubject<LightItem, Never>()
    private var debounce_timer:Timer?
    
    var intensity: Float16 = 0 {
        willSet {
            self.lightItem.intensity = newValue
            didChange.send(self.lightItem)
            self.setLightValue()
        }
    }
    var green: Float16 = 1 {
        willSet {
            self.lightItem.green = newValue
            didChange.send(self.lightItem)
            self.setLightValue()
        }
    }
    var red: Float16 = 1 {
        willSet {
            self.lightItem.red = newValue
            didChange.send(self.lightItem)
            self.setLightValue()
        }
    }
    var blue: Float16 = 1 {
        willSet {
            self.lightItem.blue = newValue
            didChange.send(self.lightItem)
            self.setLightValue()
        }
    }
    
    init(identifier: Identifier) {
        guard let lightItem = DataRepository.shared.get(favoritableId: identifier,
                                                        type: .light) as? LightItem else {
            fatalError()
        }
        self.lightItem = lightItem
    }
    
    func saveNewValues() {
        if debounce_timer == nil {
            debounce_timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: false) { _ in
                DataRepository.shared.set(favoritable: self.lightItem)
                self.debounce_timer = nil
            }
        }
    }
    
    func setLightValue() {
        if debounce_timer == nil {
            debounce_timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: false) { _ in
                OSCManager.shared.send(Float16(self.lightItem.intensity),
                                       for: .dimmer(self.lightItem.number))
                OSCManager.shared.send(Float16(self.lightItem.red),
                                       for: .red(self.lightItem.number))
                OSCManager.shared.send(Float16(self.lightItem.blue),
                                       for: .blue(self.lightItem.number))
                OSCManager.shared.send(Float16(self.lightItem.green),
                                       for: .green(self.lightItem.number))
                OSCManager.shared.send(Float16(self.lightItem.crossFade),
                                       for: .crossFade(self.lightItem.number))
                self.debounce_timer = nil
            }
        }
    }
}
