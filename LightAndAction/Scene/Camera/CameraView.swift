//
//  CameraView.swift
//  LightAndAction
//
//  Created by Yahya BOURABA on 03/07/2024.
//

import SwiftUI

struct CameraView: View {
    @Environment(\.openWindow) private var openWindow
    @StateObject private var viewModel = CameraViewModel()

    var body: some View {
        VStack {
           Text("Camera")
           Button("SetUp Camera") {
               Task {
                   if let cameraItem = try? await self.viewModel.newCamera() {
                       openWindow(id: "Camera", value: cameraItem.favoritableId)
                   }
               }
           }
       }
    }
}

#Preview {
    CameraView()
}
