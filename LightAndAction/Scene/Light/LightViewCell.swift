//
//  LightViewCell.swift
//  LightAndAction
//
//  Created by Yahya BOURABA on 04/07/2024.
//

import SwiftUI

struct LightViewCell: View {
    var lightItem: LightItem
    @ObservedObject var viewModel: MainViewModel
    @Environment(\.openWindow) private var openWindow

    var body: some View {
        HStack {
            Text(self.lightItem.identifier)
            Spacer()
            Button("Open Window") {
                openWindow(id: "Light", value: lightItem.favoritableId)
            }
        }
    }
}

