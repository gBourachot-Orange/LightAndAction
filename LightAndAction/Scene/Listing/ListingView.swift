//
//  ListingView.swift
//  LightAndAction
//
//  Created by Yahya BOURABA on 03/07/2024.
//

import SwiftUI

struct ListingView: View {
    @StateObject private var viewModel = ListingViewModel()
    
    var body: some View {
        VStack {
            Button("Save Scene") {
                viewModel.saveScene()
            }
            List {
                ForEach(viewModel.favoriteScenes) { favoriteScene in
                    FavoriteSceneCell(favoriteScene: favoriteScene)
                }
            }
        }.task {
            self.viewModel.loadFavoriteScenes()
        }
    }
}

#Preview {
    ListingView()
}
