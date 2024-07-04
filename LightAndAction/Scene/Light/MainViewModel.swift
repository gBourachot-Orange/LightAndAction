//
//  MainViewModel.swift
//  LightAndAction
//
//  Created by BOURACHOT Guillaume on 03.07.2024.
//
//

import Foundation
import SwiftUI

protocol MainViewModelLogic: AnyObject {
    func newLight() async throws -> LightItem
}

@MainActor class MainViewModel: ObservableObject, MainViewModelLogic {

    @Published var lightList: [LightItem] = []

    func newLight() async throws -> LightItem {
        guard let lightItem = DataRepository.shared.newObject(type: .light) as? LightItem else {
            throw DataRepository.RepositoryError.typeConversionFailed
        }
        lightList.append(lightItem)
        return lightItem
    }
    

    // Variables
}
