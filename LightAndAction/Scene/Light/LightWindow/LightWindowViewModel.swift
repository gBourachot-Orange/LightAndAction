//
//  LightWindowViewModel.swift
//  LightAndAction
//
//  Created by BOURACHOT Guillaume on 03.07.2024.
//
//

import Foundation

protocol LightWindowViewModelLogic: AnyObject {
    func saveNewValues() async
}

class LightWindowViewModel: ObservableObject, LightWindowViewModelLogic {
    
    // Variables
    @Published var lightItem: LightItem
    private var debounce_timer:Timer?
    
    init(identifier: Identifier) {
        guard let lightItem = DataRepository.shared.get(favoritableId: identifier,
                                                        type: .light) as? LightItem else {
            fatalError()
        }
        self.lightItem = lightItem
    }
    
    func saveNewValues() {
        debounce_timer?.invalidate()
        debounce_timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
            DataRepository.shared.set(favoritable: self.lightItem)
            OSCManager.shared.send(Float16(self.lightItem.intensity),
                                   identifier: self.lightItem.favoritableId,
                                   for: .dimmer)
        }
        
    }
}
