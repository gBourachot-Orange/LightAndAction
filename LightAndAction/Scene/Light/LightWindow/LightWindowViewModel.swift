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
    var sliderValue: Double = 0 {
        willSet {
            self.lightItem.intensity = newValue
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
                                   for: .dimmer)
        }
    }
}
