//
//  CameraItem.swift
//  LightAndAction
//
//  Created by Yahya BOURABA on 03/07/2024.
//

import Foundation

struct CameraItem {
    let identifier: Identifier
    var dataURL: URL

    init(type: ManagedItemType,
         number: Int,
         dataURL: URL) {
        self.identifier = "\(type.rawValue)-\(number)"
        self.dataURL = dataURL
    }
}

extension CameraItem: Favoritable {
    var favoritableId: Identifier {
        return self.identifier
    }

    var itemType: ManagedItemType {
        return ManagedItemType.camera
    }

    func save() {
        DataRepository.shared.set(favoritable: self)
    }
}

extension CameraItem: Hashable {

}
