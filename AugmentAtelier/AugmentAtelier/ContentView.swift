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
    @EnvironmentObject var viewModel: AtelierViewModel
    @GestureState private var dragOffset: CGSize = .zero
    @Environment(\.openWindow) private var openWindow

    let timer = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Model3D(named: viewModel.currentModelName, bundle: realityKitContentBundle)
                .rotation3DEffect(.degrees(-10), axis: (x: 1, y: 0, z: 0))
                .rotation3DEffect(viewModel.accumulatedRotation + .degrees(dragOffset.width / 2),
                                  axis: (x: 0, y: 1, z: 0))
                .gesture(
                    DragGesture()
                        .updating($dragOffset) { value, state, _ in
                            state = value.translation
                        }
                        .onEnded { value in
                            viewModel.rotate(by: value.translation.width)
                        }
                )
                .onReceive(timer) { _ in
                    if viewModel.isAutoSpinning {
                        viewModel.accumulatedRotation += .degrees(1)
                    }
                }
        }
        .ornament(visibility: .visible, attachmentAnchor: .scene(.bottomFront), contentAlignment: .center) {
            HStack(spacing: 30) {
                Button(action: {
                    viewModel.previousModel()
                }) {
                    Image(systemName: "chevron.left").font(.largeTitle)
                }

                Text(viewModel.currentModelName)

                Button(action: {
                    viewModel.isInfoActive.toggle()
                    openWindow(id: "R1")
                }) {
                    Image(systemName: viewModel.isInfoActive ? "info.circle.fill" : "info.circle")
                        .font(.largeTitle)
                }

                Button(action: {
                    viewModel.isAutoSpinning.toggle()
                }) {
                    Image(systemName: viewModel.isAutoSpinning
                          ? "arrow.trianglehead.2.clockwise.rotate.90.circle.fill"
                          : "arrow.trianglehead.2.clockwise.rotate.90.circle")
                        .font(.largeTitle)
                }

                Button(action: {
                    viewModel.nextModel()
                }) {
                    Image(systemName: "chevron.right").font(.largeTitle)
                }
            }
            .padding(.top, 20)
        }
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
        .environmentObject(AtelierViewModel())
}
