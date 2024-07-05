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
        VStack(spacing: 25) {
            video
                .clipShape(RoundedRectangle(cornerRadius: 14))
            otherVideos
        }
        .background(.clear)
    }

    private var video: some View {
        VideoPlayer(player: viewModel.videoPlayer)
            .ornament(
                visibility: .visible,
                attachmentAnchor: .scene(.top),
                contentAlignment: .center
            ) {
                Text("Camera window \(favoritableIdentifier)")
                    .padding()
                    .glassBackgroundEffect()
            }
    }

    private var otherVideos: some View {
        
        ScrollView(.horizontal) {
            HStack {
                ForEach(0 ..< 12) { item in
                    VideoPlayer(player: viewModel.videoPlayer)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .frame(width: 175, height: 100)
                        .padding()
                }
            }
        }

    }
}

#Preview {
    VideoPlayerView(favoritableIdentifier: "Camera-1")
}
