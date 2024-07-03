//
//  VideoPlayerView.swift
//  LightAndAction
//
//  Created by Yahya BOURABA on 03/07/2024.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    @StateObject var viewModel: PlayerViewModel
    let favoritableIdentifier: Identifier

    init(favoritableIdentifier: Identifier) {
        self._viewModel = StateObject(wrappedValue: PlayerViewModel(identifier: favoritableIdentifier))
        self.favoritableIdentifier = favoritableIdentifier
    }


    var body: some View {
        VStack {
            Text("Camera window \(favoritableIdentifier)")
            VideoPlayer(player: viewModel.videoPlayer)
        }
    }
}

#Preview {
    VideoPlayerView(favoritableIdentifier: "Camera-1")
}
