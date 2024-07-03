//
//  BusinessProtocols.swift
//  LightAndAction
//
//  Created by BOURACHOT Guillaume on 03.07.2024.
//

import Foundation

typealias Identifier = String
typealias Intensity = Double
typealias RepositoryKey = String

protocol Favoritable: Codable {
    var favoritableId: Identifier { get }
    var itemType: ManagedItemType { get }
    func save()
}

enum ManagedItemType: String, CaseIterable {
    case light
    case camera
}
