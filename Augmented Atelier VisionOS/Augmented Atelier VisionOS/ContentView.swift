//
//  ContentView.swift
//  Augmented Atelier VisionOS
//
//  Created by Steinhauer, Jan on 21.04.25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @State private var currentModelIndex: Int = 0

    private let modelNames = ["Jaguar_Whistle", "Frog_Game",  "Road_Pillar"]
    private let windowSize: Float = 1.0

    var body: some View {
        VStack {
            
            
            // 3D Model Viewer with Scale
            Model3D(named: modelNames[currentModelIndex], bundle: realityKitContentBundle)
                .frame(width: CGFloat(windowSize), height: CGFloat(windowSize), alignment: .center)
                .scaleEffect(65)
                .rotation3DEffect(
                        .degrees(-10), // Tilt forward by 10 degrees
                        axis: (x: 1, y: 0, z: 0)
                    )

            
        }
        .ornament(visibility: .visible, attachmentAnchor: .scene(.bottom), contentAlignment: .center){
            // Navigation Arrows
            HStack(spacing: 50) {
                Button(action: {
                    currentModelIndex = (currentModelIndex - 1 + modelNames.count) % modelNames.count
                }) {
                    Image(systemName: "chevron.left")
                        .font(.largeTitle)
                }
                
                Text(modelNames[currentModelIndex])

                Button(action: {
                    currentModelIndex = (currentModelIndex + 1) % modelNames.count
                }) {
                    Image(systemName: "chevron.right")
                        .font(.largeTitle)
                }
            }
            .padding(.top, 20)
        }
        .frame(width: CGFloat(windowSize), height: CGFloat(windowSize), alignment: .center)
    }
}


#Preview(windowStyle: .volumetric) {
    ContentView()
}
