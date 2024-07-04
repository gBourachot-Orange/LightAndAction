//
//  FavoriteSceneCell.swift
//  LightAndAction
//
//  Created by BOURACHOT Guillaume on 03.07.2024.
//

import SwiftUI

struct FavoriteSceneCell: View {
    
    let favoriteScene: FavoriteScene
    
    init(favoriteScene: FavoriteScene) {
        self.favoriteScene = favoriteScene
    }
    
    var body: some View {
        HStack {
            Text(self.favoriteScene.title)
            Spacer()
            Button("Load") {
                for favoritable in favoriteScene.favoritables {
                    DataRepository.shared.set(favoritable: favoritable)
                    OSCManager.shared.send(Float16(favoritable.intensity),
                                           for: .dimmer(favoritable.number))
                    OSCManager.shared.send(Float16(favoritable.red),
                                           for: .red(favoritable.number))
                    OSCManager.shared.send(Float16(favoritable.blue),
                                           for: .blue(favoritable.number))
                    OSCManager.shared.send(Float16(favoritable.green),
                                           for: .green(favoritable.number))
                }
            }
        }
        
    }
}

#Preview {
    FavoriteSceneCell(favoriteScene: .init(title: "test",
                                           favoritables: []))
}
