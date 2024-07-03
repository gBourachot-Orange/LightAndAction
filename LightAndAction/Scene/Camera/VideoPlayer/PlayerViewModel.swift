//
//  PlayerViewModel.swift
//  LightAndAction
//
//  Created by Yahya BOURABA on 03/07/2024.
//

import Foundation
import AVKit

@MainActor
final class PlayerViewModel: ObservableObject {

    @Published var cameraItem: CameraItem
    var videoPlayer : AVPlayer

    init(identifier: Identifier) {
        guard let cameraItem = DataRepository.shared.get(favoritableId: identifier,
                                                        type: .camera) as? CameraItem else {
            fatalError()
        }
        self.cameraItem = cameraItem

        videoPlayer = AVPlayer(url: cameraItem.dataURL)
        videoPlayer.play()
    }
}


