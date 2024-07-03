//
//  LightItem.swift
//  LightAndAction
//
//  Created by BOURACHOT Guillaume on 03.07.2024.
//

import Foundation

struct LightItem {
    let identifier: Identifier
    var intensity: Intensity
    
    init(type: ManagedItemType,
         number: Int,
         intensity: Intensity) {
        self.identifier = "\(type.rawValue)-\(number)"
        self.intensity = intensity
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
