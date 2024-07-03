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
    
    private init() {
        // Shared instance
    }
    
    enum RepositoryError: Error {
        case typeConversionFailed
    }
}

extension DataRepository: DataRepositoryLogic {
    func get(favoritableId: Identifier, type: ManagedItemType) -> Favoritable? {
        if let data = UserDefaults.standard.object(forKey: favoritableId) as? Data {
            switch type {
            case .light:
                let favoritable = try? JSONDecoder().decode(LightItem.self, from: data)
                return favoritable
            }
            return nil
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
                                      intensity: 0)
            self.set(favoritable: lightItem)
            return lightItem
        }
    }
}
