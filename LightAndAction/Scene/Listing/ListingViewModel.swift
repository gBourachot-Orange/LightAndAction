//
//  ListingViewModel.swift
//  LightAndAction
//
//  Created by Yahya BOURABA on 03/07/2024.
//

import Foundation
import SwiftUI

protocol ListingViewModelLogic: AnyObject {
    func loadFavoriteScenes()
    func saveScene()
}

class ListingViewModel: ObservableObject, ListingViewModelLogic {
    
    // Variables
    @Published var favoriteScenes: [FavoriteScene] = []
    
}

extension ListingViewModel {
    func loadFavoriteScenes() {
        let scenes = DataRepository.shared.getAllValues().filter({ $0.itemType == .scene }).compactMap { $0 as? FavoriteScene}
        favoriteScenes = scenes
    }
    
    func saveScene() {
        let lights = DataRepository.shared.getAllValues().filter({ $0.itemType == .light }).compactMap { $0 as? LightItem}
        let newScene = FavoriteScene(title: "Scene-\(favoriteScenes.count)",
                                     favoritables: lights)
        DataRepository.shared.set(favoritable: newScene)
        self.loadFavoriteScenes()
    }
}
