//
//  DataRepository.swift
//  LightAndAction
//
//  Created by BOURACHOT Guillaume on 03.07.2024.
//

import Foundation

protocol DataRepositoryLogic {
    func set(favoritable: Favoritable)
    func get(favoritableId: Identifier, type: ManagedItemType) -> Favoritable?
    func remove(favoritableId: Identifier)
    func getAllValues() -> [Favoritable]
    func removeAll()
    func newObject(type: ManagedItemType) -> Favoritable
}

class DataRepository {
    static let shared: DataRepositoryLogic = DataRepository()
    private var idArray: [Identifier] = []
    private var favoritablesLight: [LightItem] = []
    private var favoritablesCamera: [CameraItem] = []
    private var favoritablesScenes: [FavoriteScene] = []

    private init() {
        // Shared instance
    }
    
    enum RepositoryError: Error {
        case typeConversionFailed
    }
}

extension DataRepository: DataRepositoryLogic {
    func get(favoritableId: Identifier, type: ManagedItemType) -> Favoritable? {

            switch type {
            case .light:
                if let data = UserDefaults.standard.object(forKey: "favoritablesLight") as? Data {
                    let favoritables = try? JSONDecoder().decode([LightItem].self, from: data)
                    return favoritables?.first(where: { $0.favoritableId == favoritableId })
                }

            case .camera:
                if let data = UserDefaults.standard.object(forKey: "favoritablesCamera") as? Data {
                    let favoritables = try? JSONDecoder().decode([CameraItem].self, from: data)
                    return favoritables?.first(where: { $0.favoritableId == favoritableId })
                }
            case .scene:
                if let data = UserDefaults.standard.object(forKey: "favoritablesScenes") as? Data {
                    let favoritables = try? JSONDecoder().decode([FavoriteScene].self, from: data)
                    return favoritables?.first(where: { $0.favoritableId == favoritableId })
                }
            }
            return nil

    }
    
    func set(favoritable: any Favoritable) {
        if let encoded = try? JSONEncoder().encode(favoritable) {
            UserDefaults.standard.set(encoded,
                                      forKey: favoritable.favoritableId)
            if !self.idArray.contains(favoritable.favoritableId) {
                self.idArray.append(favoritable.favoritableId)
            }
        }
    }
    
    func remove(favoritableId: Identifier) {
        UserDefaults.standard.removeObject(forKey: favoritableId)
        self.idArray.removeAll(where: { $0 == favoritableId })
    }
    
    func getAllValues() -> [Favoritable] {
        var returnedArray: [Favoritable] = []
        for identifier in self.idArray {
            for type in ManagedItemType.allCases {
                if let favoritable = self.get(favoritableId: identifier,
                                              type: type) {
                    returnedArray.append(favoritable)
                }
            }
        }
        return returnedArray
    }
    
    func removeAll() {
        self.idArray.forEach { identifier in
            self.remove(favoritableId: identifier)
        }
    }
    
    func newObject(type: ManagedItemType) -> Favoritable {
        switch type {
        case .light:
            let lightItem = LightItem(type: .light,
                                      number: self.idArray.count+1,
                                      intensity: 0,
                                      green: 1,
                                      red: 1,
                                      blue: 1, 
                                      crossFade: 1)
            self.set(favoritable: lightItem)
            return lightItem

        case .camera:
            let cameraItem = CameraItem(type: .camera,
                                      number: self.idArray.count+1,
                                        dataURL: "dance_video".loadFile()!)
            self.set(favoritable: cameraItem)
            return cameraItem
        case .scene:
            fatalError("Should not happen")
        }
    }
}

