//
//  FavoriteScene.swift
//  LightAndAction
//
//  Created by BOURACHOT Guillaume on 03.07.2024.
//

import Foundation

struct FavoriteScene: Identifiable {
    var id: UUID = UUID()
    
    let title: String
    var favoritables: [LightItem]
    var itemType: ManagedItemType {
        return .scene
    }
}

extension FavoriteScene: Favoritable {
    var favoritableId: Identifier {
        return "Scene-\(id)"
    }
    
    func save() {
        DataRepository.shared.set(favoritable: self)
    }
}
