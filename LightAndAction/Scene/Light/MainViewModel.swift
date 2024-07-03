//
//  MainViewModel.swift
//  LightAndAction
//
//  Created by BOURACHOT Guillaume on 03.07.2024.
//
//

import Foundation

protocol MainViewModelLogic: AnyObject {
    func newLight() async throws -> LightItem
}

@MainActor class MainViewModel: ObservableObject, MainViewModelLogic {
    
    func newLight() async throws -> LightItem {
        guard let lightItem = DataRepository.shared.newObject(type: .light) as? LightItem else {
            throw DataRepository.RepositoryError.typeConversionFailed
        }
        return lightItem
    }
    

    // Variables
}
