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
    var intensity: Double = 0 {
        willSet {
            self.lightItem.intensity = newValue
            didChange.send(self.lightItem)
            self.setLightValue()
        }
    }
    var green: Float16 = 0 {
        willSet {
            self.lightItem.green = newValue
            didChange.send(self.lightItem)
            self.setLightValue()
        }
    }
    var red: Float16 = 0 {
        willSet {
            self.lightItem.red = newValue
            didChange.send(self.lightItem)
            self.setLightValue()
        }
    }
    var blue: Float16 = 0 {
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
        debounce_timer?.invalidate()
        debounce_timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { _ in
            DataRepository.shared.set(favoritable: self.lightItem)
        }
    }
    
    func setLightValue() {
        debounce_timer?.invalidate()
        debounce_timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { _ in
            OSCManager.shared.send(Float16(self.lightItem.intensity),
                                   identifier: self.lightItem.favoritableId,
                                   for: .dimmer(self.lightItem.number))
            OSCManager.shared.send(Float16(self.lightItem.red),
                                   identifier: self.lightItem.favoritableId,
                                   for: .red(self.lightItem.number))
            OSCManager.shared.send(Float16(self.lightItem.blue),
                                   identifier: self.lightItem.favoritableId,
                                   for: .blue(self.lightItem.number))
            OSCManager.shared.send(Float16(self.lightItem.green),
                                   identifier: self.lightItem.favoritableId,
                                   for: .green(self.lightItem.number))
            OSCManager.shared.send(Float16(self.lightItem.crossFade),
                                   identifier: self.lightItem.favoritableId,
                                   for: .crossFade(self.lightItem.number))
        }
    }
}
