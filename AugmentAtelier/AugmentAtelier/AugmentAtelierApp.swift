//
//  AugmentAtelierApp.swift
//  AugmentAtelier
//
//  Created by Steinhauer, Jan on 16.03.25.
//

import SwiftUI

@main
struct AugmentAtelierApp: App {
    @StateObject private var viewModel = AtelierViewModel()

    var body: some Scene {
        WindowGroup(id: "MainAtelier") {
            ContentView()
                .environmentObject(viewModel)
        }
        .windowStyle(.volumetric)

        WindowGroup(id: "R1") {
            DetailedArtView()
                .environmentObject(viewModel)
        }
        .windowResizability(.contentSize)
        .defaultWindowPlacement { content, context in
            if let mainWindow = context.windows.first(where: { $0.id == "MainAtelier" }) {
                WindowPlacement(.trailing(mainWindow))
            } else {
                WindowPlacement()
            }
        }
    }
}


