//
//  DetailedArtView.swift
//  AugmentAtelier
//
//  Created by Steinhauer, Jan on 24.04.25.
//

import SwiftUI
import MapKit
import AVKit

struct DetailedArtView: View {
    @EnvironmentObject var viewModel: AtelierViewModel

    var description: String {
        switch viewModel.currentModelName {
        case "Jaguar Whistle":
            return "An ancient Mesoamerican whistle shaped like a jaguar. Used in rituals and known for its eerie sound."
        case "Frog Game":
            return "A traditional game involving frog figurines. Possibly a representation of early interactive art."
        case "Road Pillar":
            return "A sculptural representation of infrastructural design — where art meets utility."
        default:
            return "No description available."
        }
    }

    @State private var michoacanRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 19.1538, longitude: -101.8834),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )

    var body: some View {
        VStack(spacing: 20) {
            Text(viewModel.currentModelName)
                .font(.largeTitle)
                .bold()

            Text(description)
                .multilineTextAlignment(.leading)
                .padding()
                .frame(width: 500, height: 100)

            Group {
                switch viewModel.currentModelName {
                case "Jaguar Whistle":
                    Map(position: .constant(
                        MapCameraPosition.region(
                            MKCoordinateRegion(
                                center: CLLocationCoordinate2D(latitude: 19.1, longitude: -101.8),
                                span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                            )
                        ))
                    ) {
                        
                    }
                    .frame(width: 500, height: 500)

                case "Frog Game":
                    Image("FrogGamePic")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 500, height: 500)

                case "Road Pillar":
                    if let url = Bundle.main.url(forResource: "RoadPillarVid", withExtension: "mp4") {
                        VideoPlayer(player: AVPlayer(url: url))
                            .frame(width: 500, height: 500)
                    } else {
                        Text("Video not found.")
                    }

                default:
                    EmptyView()
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.isInfoActive = true
        }
        .onDisappear {
            viewModel.isInfoActive = false
        }
    }
}

#Preview {
    DetailedArtView()
        .environmentObject(AtelierViewModel())
}

