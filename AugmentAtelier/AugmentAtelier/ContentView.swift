//
//  ContentView.swift
//  AugmentAtelier
//
//  Created by Steinhauer, Jan on 16.03.25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @State private var currentModelIndex: Int = 0
    @GestureState private var dragOffset: CGSize = .zero
    @State private var accumulatedRotation: Angle = .zero

    private let modelNames = ["Jaguar Whistle", "Frog Game",  "Road Pillar"]
    private let windowSize: Float = 1.0

    var body: some View {
        VStack {
            Model3D(named: modelNames[currentModelIndex], bundle: realityKitContentBundle)
                .rotation3DEffect(
                    .degrees(-10),
                    axis: (x: 1, y: 0, z: 0)
                )
                .rotation3DEffect(
                    accumulatedRotation + .degrees(dragOffset.width / 2),
                    axis: (x: 0, y: 1, z: 0)
                )
                .gesture(
                    DragGesture()
                        .updating($dragOffset) { value, state, _ in
                            state = value.translation
                        }
                        .onEnded { value in
                            accumulatedRotation += .degrees(value.translation.width / 2)
                        }
                )
        }
        .ornament(visibility: .visible, attachmentAnchor: .scene(.bottomFront), contentAlignment: .center) {
            HStack(spacing: 50) {
                Button(action: {
                    currentModelIndex = (currentModelIndex - 1 + modelNames.count) % modelNames.count
                    accumulatedRotation = .zero
                }) {
                    Image(systemName: "chevron.left")
                        .font(.largeTitle)
                }

                Text(modelNames[currentModelIndex])

                Button(action: {
                    currentModelIndex = (currentModelIndex + 1) % modelNames.count
                    accumulatedRotation = .zero
                }) {
                    Image(systemName: "chevron.right")
                        .font(.largeTitle)
                }
            }
            .padding(.top, 20)
        }
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
