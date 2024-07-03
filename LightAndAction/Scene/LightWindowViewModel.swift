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

@MainActor class LightWindowViewModel: ObservableObject, LightWindowViewModelLogic {
    
    // Variables
    @Published var lightItem: LightItem
    
    init(identifier: Identifier) {
        guard let lightItem = DataRepository.shared.get(favoritableId: identifier,
                                                        type: .light) as? LightItem else {
            fatalError()
        }
        self.lightItem = lightItem
    }
    
    func saveNewValues() {
        DataRepository.shared.set(favoritable: self.lightItem)
    }
}
