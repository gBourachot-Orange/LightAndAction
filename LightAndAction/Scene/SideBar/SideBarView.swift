//
//  SideBarView.swift
//  LightAndAction
//
//  Created by Yahya BOURABA on 03/07/2024.
//

import SwiftUI

struct SideBarView: View {
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Label("Light", systemImage: "rays")
                }
            CameraView()
                .tabItem {
                    Label("Camera", systemImage: "camera.viewfinder")
                }
            ListingView()
                .tabItem {
                    Label("Listing", systemImage: "switch.2")
                }
        }
    }
}

#Preview {
    SideBarView()
}
