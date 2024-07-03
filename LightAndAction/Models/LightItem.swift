//
//  LightItem.swift
//  LightAndAction
//
//  Created by BOURACHOT Guillaume on 03.07.2024.
//

import Foundation

struct LightItem {
    let identifier: Identifier
    let number: Int
    var intensity: Intensity
    var green: Float16
    var red: Float16
    var blue: Float16
    var crossFade: Float16
    
    init(type: ManagedItemType,
         number: Int,
         intensity: Intensity,
         green: Float16,
         red: Float16,
         blue: Float16,
         crossFade: Float16) {
        self.identifier = "\(type.rawValue)-\(number)"
        self.number = number
        self.intensity = intensity
        self.green = green
        self.red = red
        self.blue = blue
        self.crossFade = crossFade
    }
}

extension LightItem: Favoritable {
    var favoritableId: Identifier {
        return self.identifier
    }
    
    var itemType: ManagedItemType {
        return ManagedItemType.light
    }
    
    func save() {
        DataRepository.shared.set(favoritable: self)
    }
}

extension LightItem: Hashable {
    
}
