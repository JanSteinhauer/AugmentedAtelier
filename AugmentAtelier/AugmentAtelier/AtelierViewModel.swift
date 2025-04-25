//
//  AtelierViewModel.swift
//  AugmentAtelier
//
//  Created by Steinhauer, Jan on 25.04.25.
//

import SwiftUI
import Combine

class AtelierViewModel: ObservableObject {
    @Published var currentModelIndex: Int = 0
    @Published var accumulatedRotation: Angle = .zero
    @Published var isAutoSpinning: Bool = false
    @Published var isInfoActive: Bool = false
    
    let modelNames = ["Jaguar Whistle", "Frog Game", "Road Pillar"]

    var currentModelName: String {
        modelNames[currentModelIndex]
    }

    func rotate(by delta: CGFloat) {
        accumulatedRotation += .degrees(delta / 2)
    }

    func previousModel() {
        currentModelIndex = (currentModelIndex - 1 + modelNames.count) % modelNames.count
        accumulatedRotation = .zero
    }

    func nextModel() {
        currentModelIndex = (currentModelIndex + 1) % modelNames.count
        accumulatedRotation = .zero
    }
}

